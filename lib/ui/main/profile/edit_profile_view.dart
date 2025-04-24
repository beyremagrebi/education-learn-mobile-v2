import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:studiffy/core/localization/loalisation.dart';

import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/utils/view_models/main/global_user_consumer.dart';

import 'package:studiffy/utils/widgets/from/buttons/loading_button.dart';

import '../../../core/constant/assets.dart';
import '../../../utils/app/session/session_manager.dart';
import '../../../utils/widgets/background_image_safe_area.dart';
import '../../../utils/widgets/from/inputs/input_text.dart';
import '../../../utils/widgets/media/api_image_widget.dart';
import 'edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(context, user: SessionManager.user),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(intl.editProfile),
        ),
        body: BackgroundImageSafeArea(
          svgAsset: Assets.bgMain,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Consumer<EditProfileViewModel>(
              builder: (_, viewModel, ___) => Padding(
                padding: Dimensions.paddingExtraLargeHorizontal,
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      _buildAvatarChange(context, viewModel),
                      Dimensions.heightHuge,
                      _buildUserInformationForm(context, viewModel),
                      Dimensions.heightHuge,
                      _buildSubmitButtonForm(context, viewModel)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarChange(
      BuildContext context, EditProfileViewModel viewModel) {
    return GestureDetector(
      onTap: viewModel.getImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          viewModel.file != null
              ? ClipOval(
                  child: Image(
                    image: ResizeImage(
                      FileImage(viewModel.file!),
                      width: (MediaQuery.of(context).size.width *
                              0.40 *
                              Dimensions.dpr)
                          .round(),
                      height: (MediaQuery.of(context).size.width *
                              0.40 *
                              Dimensions.dpr)
                          .round(),
                    ),
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.width * 0.40,
                    fit: BoxFit.cover,
                  ),
                )
              : GlobalUserConsumer(
                  builder: (context, user) => ApiImageWidget(
                    width: MediaQuery.of(context).size.width * (0.40),
                    height: MediaQuery.of(context).size.width * (0.40),
                    imageFilename: user.imageFilename,
                    isMen: user.isMen,
                    isProfilePicture: true,
                  ),
                ),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInformationForm(
      BuildContext context, EditProfileViewModel viewModel) {
    return Column(
      children: [
        InputText(
          controller: viewModel.firstNameController,
          label: intl.firstName,
          hint: viewModel.user.firstName,
        ),
        Dimensions.heightMedium,
        InputText(
          controller: viewModel.lastNameController,
          label: intl.lastName,
        ),
        Dimensions.heightMedium,
        InputText(
          controller: viewModel.emailController,
          label: intl.email,
        ),
        Dimensions.heightMedium,
        InputText(
          controller: viewModel.phoneController,
          label: intl.phone,
          isRequired: true,
        ),
        Dimensions.heightMedium,
        InputText(
          controller: viewModel.locationController,
          label: intl.address,
        ),
      ],
    );
  }

  Widget _buildSubmitButtonForm(
      BuildContext context, EditProfileViewModel viewModel) {
    return LoadingButton(
        isLoading: viewModel.isBusy,
        onPressed: () {
          viewModel.submit(context);
        },
        child: Text(
          intl.saveChanges,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onInverseSurface),
        ));
  }
}
