import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app/app_router.dart';

import 'package:graduation_project/app/extensions.dart';

import '../../app/app_colors.dart';
import '../../app/app_sized_box.dart';
import '../../app/document_picker.dart';
import '../../app/text_style.dart';
import '../componnents/custom_dialog.dart';
import 'image_cubit/image_cubit.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return addingImageWidget();
    });
  }

  Widget addingImageWidget() {
    return BlocBuilder<ImageCubit, ImageState>(builder: (context, state) {
      ImageCubit cubit = ImageCubit.get(context);
      // File? userImage = cubit.image;
      return FormField<File>(
        initialValue: cubit.image,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (File? value) {
          if (cubit.image == null) {
            return "add photo";
          }
          return null;
        },
        builder: (state) => InkWell(
          onTap: cubit.image != null
              ? () async {
                  Navigator.pushNamed(context, AppRouter.showPhotosScreen,
                      arguments: [cubit.image!]);
                }
              : null,
          child: Column(
            children: [
              SizedBox(
                width: 200,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey[500],
                      foregroundImage:
                          cubit.image != null ? FileImage(cubit.image!) : null,
                      child: const Icon(
                        Icons.photo_library_outlined,
                        size: 100,
                      ),
                    ),
                    cameraIconWidget(state),
                  ],
                ),
              ),
              AppSizedBox.h3,
              if (state.hasError &&
                  state.errorText != null &&
                  state.errorText != "")
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(
                    state.errorText!,
                    style: AppTextStyle.getRegularStyle(
                        color: AppColors.errorColor, fontSize: 10.sp),
                  ),
                )
            ],
          ),
        ),
      );
    });
  }

  Widget cameraIconWidget(FormFieldState<File> state) {
    return Builder(builder: (context) {
      ImageCubit cubit = ImageCubit.get(context);
      return Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: InkResponse(
                onTap: cubit.image != null
                    ? () {
                        cubit.removeImage();
                        state.didChange(cubit.image);
                      }
                    : () async {
                        // var result = await showImagePikerDialog(context);
                        // if (result != null) {
                        await cubit.pickImage(PickImageFromEnum.gallery);
                        state.didChange(cubit.image);
                        //}
                      },
                child: Container(
                  padding: const EdgeInsetsDirectional.all(5),
                  child: Icon(
                    cubit.image == null ? Icons.camera_alt : Icons.delete,
                    color: Colors.white,
                    size: 13.sp,
                  ),
                )),
          ),
        ),
      );
    });
  }

  Future<PickImageFromEnum?> showImagePikerDialog(BuildContext context) async {
    var result = await CustomDialog.show(
        context: context,
        dialogContent: Container(
          alignment: AlignmentDirectional.center,
          color: AppColors.background,
          height: 30.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              imageTypeWidget(Icons.camera, "الكاميرا", () {
                Navigator.pop(context, PickImageFromEnum.camera);
              }),
              imageTypeWidget(Icons.photo_camera_back, "الصور", () {
                Navigator.pop(context, PickImageFromEnum.gallery);
              }),
            ],
          ),
        ));
    return result;
  }

  Widget imageTypeWidget(IconData icon, String text, Function onTap) {
    return Builder(builder: (context) {
      return Material(
        color: AppColors.background,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          onTap: () => onTap(),
          child: Container(
            padding: EdgeInsets.all(10.sp),
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                border: Border.all(color: AppColors.blackColor, width: 2)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 35.sp,
                  color: AppColors.primaryColor,
                ),
                AppSizedBox.h2,
                Text(
                  text,
                  style: AppTextStyle.getRegularStyle(
                      color: AppColors.primaryColor, fontSize: 20.sp),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
