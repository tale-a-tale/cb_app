import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/post_model.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import 'base_models.dart';

class CreatePostViewModel extends BaseModel {

  final FireStoreService _firestoreService = locator<FireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Post _edittingPost;
  bool get _editting => _edittingPost != null;

  Future addPost({@required String title, @required String description}) async {
    setBusy(true);

    var result;

    if (!_editting) {
      result = await _firestoreService
          .addPost(Post(title: title, userId: currentUser.id, description: description));
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        description: description,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}