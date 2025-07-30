import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/profile/data/models/learner_profile_model/Learner_profile_model.dart';
import 'package:darrbiny/features/profile/data/models/learners_profile_update/Learners_profile_update.dart';
import 'package:darrbiny/features/profile/data/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/storage_service.dart';

class ProfileRepoImpl extends ProfileRepo{
  @override
  Future<Either<Failure, LearnerProfileModel>> postLearnerProfile() async {
    try {
      final String? learnerId = await StorageService().getUserId();

      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.learnersProfile,
        data: {"learner_id": learnerId},
      );

      return right(LearnerProfileModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LearnersProfileUpdate>> postLearnerUpdateProfile({
    required String name,
    required String filePath,
  }) async {
    try {
      final String? learnerId = await StorageService().getUserId();

      FormData formData = FormData.fromMap({
        "name": name,
        "profile_image": await MultipartFile.fromFile(
          filePath,
          filename: filePath.split("/").last,
        ),
      });

      final Response response = await DioHelper.postDataWithoutToken(
        url: "${AppEndpoints.learnersUpdate}/$learnerId",
        data: formData,
      );

      return right(LearnersProfileUpdate.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}