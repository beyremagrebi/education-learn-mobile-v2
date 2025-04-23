import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:studiffy/core/base/base_view_model.dart';

import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/utils/alert_utils.dart';

import '../../../core/api/services/global/user_service.dart';
import '../../../models/global/user/user.dart';
import '../../../utils/app/session/session_manager.dart';

class EditProfileViewModel extends BaseViewModel {
  final User user;
  File? file;
  bool _isAdd = false;
  final picker = ImagePicker();

  EditProfileViewModel(super.context, {required this.user}) {
    _setupTextFieldListeners();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      file = File(pickedFile.path);
      _isAdd = true;
      update();
    }
  }

  final formKey = GlobalKey<FormState>();

  bool get isAdd => _isAdd;

  late final TextEditingController firstNameController = TextEditingController(
    text: SessionManager.user.firstName,
  );
  late final TextEditingController lastNameController = TextEditingController(
    text: SessionManager.user.lastName,
  );
  late final TextEditingController emailController = TextEditingController(
    text: SessionManager.user.email,
  );
  late final TextEditingController phoneController = TextEditingController(
    text: SessionManager.user.phoneNumber,
  );
  late final TextEditingController locationController = TextEditingController(
    text: SessionManager.user.address,
  );

  void _setupTextFieldListeners() {
    firstNameController.addListener(_updateIsAdd);
    lastNameController.addListener(_updateIsAdd);
    emailController.addListener(_updateIsAdd);
    phoneController.addListener(_updateIsAdd);
    locationController.addListener(_updateIsAdd);
  }

  void _updateIsAdd() {
    bool hasChanges = firstNameController.text != user.firstName ||
        lastNameController.text != user.lastName ||
        emailController.text != user.email ||
        phoneController.text != user.phoneNumber ||
        locationController.text != user.address;

    if (_isAdd != hasChanges) {
      _isAdd = hasChanges;
      update();
    }
  }

  Future<void> submit(BuildContext context, {Completion? completion}) async {
    isBusy = true;
    FocusScope.of(context).unfocus();

    if (!_isAdd) {
      showErrorMessage(intl.noChangesToUpdate);
      isBusy = false;

      return;
    }
    if (firstNameController.text.trim().isEmpty) {
      showErrorMessage(intl.pleaseEnterYourEmail);
      isBusy = false;

      return;
    }

    if (lastNameController.text.trim().isEmpty) {
      showErrorMessage(intl.pleaseEnterYourLastName);
      isBusy = false;

      return;
    }

    if (emailController.text.trim().isEmpty) {
      showErrorMessage(intl.pleaseEnterYourEmail);
      isBusy = false;

      return;
    }
    if (phoneController.text.trim().isEmpty) {
      showErrorMessage(intl.pleaseEnterYourPhoneNumber);
      isBusy = false;

      return;
    }
    if (locationController.text.trim().isEmpty) {
      showErrorMessage(intl.pleaseEnterYourAddress);
      isBusy = false;

      return;
    }

    if (formKey.currentState!.validate()) {
      User userToUpdate = SessionManager.user;
      userToUpdate.firstName = firstNameController.text;
      userToUpdate.lastName = lastNameController.text;
      userToUpdate.email = emailController.text;
      userToUpdate.phoneNumber = phoneController.text;
      userToUpdate.address = locationController.text;

      if (file != null) {
        await makeApiCall(
          fromMapFunction: User.fromMap,
          apiCall: UserService.shared
              .updateUserProfileImage(user: userToUpdate, filePath: file!.path),
          onSuccess: (data) {
            if (data?.id != null) {
              SessionManager.saveUser(data!);
              if (context.mounted) Navigator.pop(context);
            }
          },
        );
      } else {
        await makeApiCall(
          fromMapFunction: User.fromMap,
          apiCall: UserService.shared.updateUserProfile(
            user: userToUpdate,
          ),
          onSuccess: (data) {
            if (data?.id != null) {
              SessionManager.saveUser(data!);
            }
            if (context.mounted) Navigator.pop(context);
          },
        );
      }
    }

    isBusy = false;
    update();
  }

  void showErrorMessage(String errorMessage) {
    AlertUtils.show(
      title: intl.genericError,
      description: errorMessage,
      dialogType: DialogType.warning,
    );
  }

  @override
  void dispose() {
    firstNameController.removeListener(_updateIsAdd);
    lastNameController.removeListener(_updateIsAdd);
    emailController.removeListener(_updateIsAdd);
    phoneController.removeListener(_updateIsAdd);
    locationController.removeListener(_updateIsAdd);
    file = null;
    super.dispose();
  }
}
