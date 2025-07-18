import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as location_package;
import 'package:geocoding/geocoding.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';

class LocationController extends GetxController {
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  Rxn<LatLng> selectedMapLocation = Rxn<LatLng>();

  void setMapLocation(LatLng latLng) {
    selectedMapLocation.value = latLng;
    _updateAddressFromCoordinates(latLng);
  }

  Future<void> _updateAddressFromCoordinates(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        countryController.text = place.country ?? 'غير محدد';

        String city = place.locality ??
            place.subAdministrativeArea ??
            place.administrativeArea ??
            'غير محدد';
        cityController.text = city;

        String area = '';

        if (place.subLocality?.isNotEmpty ?? false) {
          area = place.subLocality!;
        }
        else if (place.street?.isNotEmpty ?? false) {
          area = place.street!;
        }
        else if (place.subAdministrativeArea?.isNotEmpty ?? false) {
          area = place.subAdministrativeArea!;
        }
        else {
          area = city;
        }

        areaController.text = area;

        print('النتائج النهائية:');
        print('البلد: ${countryController.text}');
        print('المدينة: ${cityController.text}');
        print('الحي: ${areaController.text}');
      }
    } catch (e) {
      print('حدث خطأ في جلب بيانات العنوان: $e');
      areaController.text = cityController.text.isNotEmpty
          ? cityController.text
          : 'غير محدد';
    }
  }  void clearAll() {
    countryController.clear();
    cityController.clear();
    areaController.clear();
    selectedMapLocation.value = null;
  }
}

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر الموقع',
          style: AppStyles.textStyle14500.copyWith(color: kGray400),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.imagesLocation2),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _TextInputField(
                      label: 'الدولة',
                      controller: locationController.countryController,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _TextInputField(
                      label: 'المدينة',
                      controller: locationController.cityController,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _TextInputField(
                      label: 'الحي',
                      controller: locationController.areaController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.location_on_outlined, size: 24),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kGray500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () async {
                    final result = await Get.to(() => const LocationPickerMap());
                    if (result != null && result is LatLng) {
                      locationController.setMapLocation(result);
                    }
                  },
                  label: Text(
                    'اختر من على الخريطة',
                    style: AppStyles.textStyle14500.copyWith(color: const Color(0xFF333333)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _TextInputField({
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.textStyle14500.copyWith(color: kGray400),
        ),
        SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'اكتب هنا',
            ),
          ),
        ),
      ],
    );
  }
}

class LocationPickerMap extends StatefulWidget {
  const LocationPickerMap({super.key});

  @override
  State<LocationPickerMap> createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  LatLng? pickedLocation;
  LatLng? currentLocation;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = location_package.Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() {
            errorMessage = 'الرجاء تفعيل خدمة الموقع';
            isLoading = false;
          });
          return;
        }
      }

      location_package.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == location_package.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != location_package.PermissionStatus.granted) {
          setState(() {
            errorMessage = 'الرجاء منح صلاحيات الموقع';
            isLoading = false;
          });
          return;
        }
      }

      final locData = await location.getLocation();
      setState(() {
        currentLocation = LatLng(locData.latitude!, locData.longitude!);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'حدث خطأ في تحديد الموقع';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اختر الموقع من الخريطة',
          style: AppStyles.textStyle14500.copyWith(color: const Color(0xFF333333)),
        ),
      ),
      body: _buildMapContent(),
    );
  }

  Widget _buildMapContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, style: AppStyles.textStyle14500),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('حاول مرة أخرى'),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: currentLocation!,
            initialZoom: 15.0,
            onTap: (_, point) => setState(() => pickedLocation = point),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.drbny',
            ),
            MarkerLayer(
              markers: [
                if (pickedLocation != null)
                  Marker(
                    point: pickedLocation!,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                  ),
                Marker(
                  point: currentLocation!,
                  width: 30,
                  height: 30,
                  child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
                ),
              ],
            ),
          ],
        ),
        if (pickedLocation != null)
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () => Get.back(result: pickedLocation),
              child: const Text('تأكيد اختيار الموقع'),
            ),
          ),
      ],
    );
  }
}