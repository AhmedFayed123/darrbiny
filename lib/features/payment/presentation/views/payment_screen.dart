import 'package:country_picker/country_picker.dart';
import 'package:darrbiny/core/constant/styles.dart';
import 'package:darrbiny/features/payment/presentation/views/widgets/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/constant/colors.dart';
import '../../../home/presentation/controller/home_controller/home_controller.dart';
import '../../data/models/charge_model/charge_model.dart';
import '../../data/models/payment_request_model/Payment_request_model.dart';
import '../controller/payment_controller.dart';

final List<Map<String, String>> currencies = [
  {"name": "Saudi Riyal", "code": "SAR"},
  {"name": "UAE Dirham", "code": "AED"},
  {"name": "Bahraini Dinar", "code": "BHD"},
  {"name": "Kuwaiti Dinar", "code": "KWD"},
  {"name": "Omani Riyal", "code": "OMR"},
  {"name": "Qatari Riyal", "code": "QAR"},
  {"name": "US Dollar", "code": "USD"},
  {"name": "Euro", "code": "EUR"},
  {"name": "UK Pound Sterling", "code": "GBP"},
];

class PaymentScreen extends StatelessWidget {
  PaymentScreen({
    super.key,
    required this.amount,
    required this.orderId,
  });

  final double amount;
  final String orderId;

  final PaymentController controller = Get.put(PaymentController());
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryCodeController = TextEditingController(text: "+966");

  final RxString selectedCurrency = "SAR".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إجراء الدفع", style: AppStyles.textStyle14500)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // عرض المبلغ
                TextFormField(
                  initialValue: amount.toString(),
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "المبلغ",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(height: 12.h),

                // اختيار العملة
                Obx(() => DropdownButtonFormField<String>(
                  value: selectedCurrency.value,
                  decoration: InputDecoration(
                    labelText: "العملة",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  items: currencies.map((currency) {
                    return DropdownMenuItem<String>(
                      value: currency["code"]!,
                      child: Text("${currency["name"]} (${currency["code"]})"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) selectedCurrency.value = value;
                  },
                )),
                SizedBox(height: 12.h),

                // رقم الطلب
                TextFormField(
                  initialValue: orderId,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "رقم الطلب",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(height: 12.h),

                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "الوصف (اختياري)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ),
                _buildTextField(firstNameController, "الاسم الأول"),
                _buildTextField(lastNameController, "اسم العائلة"),
                _buildTextField(emailController, "البريد الإلكتروني", TextInputType.emailAddress),
                _buildTextField(phoneController, "رقم الهاتف", TextInputType.phone),

                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: TextFormField(
                    controller: countryCodeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "كود الدولة",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                    onTap: () {
                      showCountryPicker(
                        context: Get.context!,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          countryCodeController.text = "+${country.phoneCode}";
                        },
                      );
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يرجى اختيار كود الدولة";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.h),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    onPressed: _onPayPressed,
                    child: const Text("ادفع الآن", style: TextStyle(color: Colors.white)),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label, [TextInputType type = TextInputType.text]) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "يرجى إدخال $label";
          }
          return null;
        },
      ),
    );
  }

  void _onPayPressed() {
    if (!_formKey.currentState!.validate()) return;

    final paymentRequest = PaymentRequestModel(
      amount: amount,
      currency: selectedCurrency.value,
      orderId: orderId,
      description: descriptionController.text.trim().isEmpty
          ? ""
          : descriptionController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      countryCode: countryCodeController.text.trim(),
    );

    controller.postPayment(
      paymentRequest,
      onSuccess: (response) {
        if (response.redirectUrl != null && response.redirectUrl!.isNotEmpty) {
          Get.to(() => PaymentWebView(url: response.redirectUrl!, chargeId: response.chargeId!,));
        }
      },
      onError: (msg) {
        Get.snackbar("خطأ", msg);
      },
    );
  }
}

class PaymentWebView extends StatefulWidget {
  final String url;
  final String chargeId;
  const PaymentWebView({super.key, required this.url, required this.chargeId});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _webController;
  final PaymentController _paymentController = Get.find<PaymentController>();
  bool _isProcessing = false;
  bool _paymentCompleted = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) => _handlePageFinish(url),
          onNavigationRequest: (request) => _handleNavigation(request),
          onWebResourceError: (error) => _handleError(),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  NavigationDecision _handleNavigation(NavigationRequest request) {
    if (_isCompletionUrl(request.url)) {
      _verifyPaymentStatus();
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void _handlePageFinish(String url) {
    if (_isCompletionUrl(url)) {
      _verifyPaymentStatus();
    }
  }

  void _handleError() {
    if (!_paymentCompleted) {
      Get.snackbar('Error', 'Failed to load payment page');
      Get.back(result: false);
    }
  }

  bool _isCompletionUrl(String url) {
    return url.contains('success') ||
        url.contains('completed') ||
        url.contains('callback') ||
        url.contains('return');
  }

  Future<void> _verifyPaymentStatus() async {
    if (_isProcessing || _paymentCompleted) return;
    _isProcessing = true;

    await _paymentController.getCharge(
      widget.chargeId,
      onSuccess: (response) {
        _isProcessing = false;
        _handlePaymentResponse(response);
      },
      onError: (error) {
        _isProcessing = false;
        _handlePaymentError(error);
      },
    );
  }

  void _handlePaymentResponse(ChargeModel response) async {
    if (response.success == true && response.data != null) {
      final status = response.data!.status?.toUpperCase();
      final homeController = Get.find<HomeController>();

      switch (status) {
        case 'CAPTURED':
          _paymentCompleted = true;

          try {
            if (homeController.tempBookingRequest != null) {
              await homeController.submitRequest(homeController.tempBookingRequest!);
              homeController.tempBookingRequest = null;

              if (homeController.submitError.isEmpty) {
                Get.offAll(() => PaymentSuccessScreen(chargeModel: response));
              }
            }
          } catch (e) {
            Get.snackbar('Error', 'Payment succeeded but booking failed');
            Get.back(result: false);
          }
          break;

        case 'PENDING':
          _retryStatusCheck();
          break;

        default:
          Get.snackbar('Failed', 'Payment was not completed');
          Get.back(result: false);
      }
    } else {
      Get.snackbar('Error', 'Payment verification failed');
      Get.back(result: false);
    }
  }

  void _handlePaymentError(String error) {
    final errorMessage = error.contains('Charge not found')
        ? 'Payment verification failed. Please check your payment status later.'
        : 'Error verifying payment: $error';

    Get.snackbar('Error', errorMessage);
    Get.back(result: false);
  }

  void _retryStatusCheck() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && !_paymentCompleted) {
        _verifyPaymentStatus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_paymentCompleted) return true;

        final shouldClose = await _showExitConfirmation();
        if (shouldClose) {
          Get.back(result: false);
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("عملية الدفع", style: AppStyles.textStyle14500),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              if (_paymentCompleted) {
                Get.back(result: true);
              } else {
                final shouldClose = await _showExitConfirmation();
                if (shouldClose) Get.back(result: false);
              }
            },
          ),
        ),
        body: WebViewWidget(controller: _webController),
      ),
    );
  }

  Future<bool> _showExitConfirmation() async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text('تأكيد الإلغاء'),
        content: const Text('هل أنت متأكد من إلغاء عملية الدفع؟'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('لا'),
          ),
          TextButton(
            onPressed: () {
              final homeController = Get.find<HomeController>();
              homeController.tempBookingRequest = null;
              Get.back(result: true);
            },
            child: const Text('نعم'),
          ),
        ],
      ),
    ) ?? false;
  }
}