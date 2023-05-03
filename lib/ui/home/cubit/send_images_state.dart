part of 'send_images_cubit.dart';

abstract class SendImagesState extends Equatable {
  const SendImagesState();

  @override
  List<Object> get props => [];
}

class SendImagesInitial extends SendImagesState {}

class LoadinSendImages extends SendImagesState {}

class SCSendImages extends SendImagesState {}

class ErorrSendImages extends SendImagesState {}
