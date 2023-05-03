import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/app/app_colors.dart';
import 'package:graduation_project/app/app_sized_box.dart';
import 'package:graduation_project/ui/componnents/custom_button.dart';
import 'package:graduation_project/ui/home/image_widget.dart';

import '../../app/app_router.dart';
import 'cubit/send_images_cubit.dart';
import 'image_cubit/image_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late ImageCubit image1 = ImageCubit();
  late ImageCubit image2 = ImageCubit();
  @override
  void initState() {
    super.initState();
  }

  ImageCubit getCubit(BuildContext context, ImageCubit cubit) {
    cubit = ImageCubit.get(context);
    return cubit;
  }

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      child: BlocProvider(
        create: (context) => SendImagesCubit(),
        child: BlocConsumer<SendImagesCubit, SendImagesState>(
          listener: (context, state) {
            SendImagesCubit cubit = SendImagesCubit.get(context);
            if (state is SCSendImages && cubit.prediction != null) {
              Navigator.pushNamed(context, AppRouter.showPhotosScreen,
                  arguments: [cubit.prediction!]);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: (state is LoadinSendImages)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Form(
                      key: _formKey,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSizedBox.h15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BlocProvider.value(
                                  value: image1,
                                  child: const ImageWidget(),
                                ),
                                BlocProvider.value(
                                  value: image2,
                                  child: const ImageWidget(),
                                ),
                              ],
                            ),
                            AppSizedBox.h15,
                            CustomButton(
                                text: "start",
                                butcolor: AppColors.primaryColor,
                                fontsize: 7,
                                height: 40,
                                width: 300,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    SendImagesCubit.get(context).upload(
                                        image1: image1.image!,
                                        image2: image2.image!,
                                        context: context);
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

//Lesson #1 Toast
void buildToast(BuildContext ctx, String text) {
  showToast(
    text,
    backgroundColor: Colors.white,
    textStyle: const TextStyle(color: Colors.black),
    context: ctx,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.bottom,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}
