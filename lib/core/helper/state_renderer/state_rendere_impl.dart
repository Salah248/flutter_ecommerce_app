import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/helper/state_renderer/state_renderer.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}
// loading state (POPUP,FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState({required this.stateRendererType, String message = 'loading'});

  @override
  String getMessage() => message ?? 'loading';

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (POPUP,FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => '';

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// EMPTY STATE

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

// success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case const (LoadingState):
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // Show popup loading
            showPopup(context, getStateRendererType(), getMessage());
            // Return the content screen widget
            return contentScreenWidget;
          } else {
            // Full screen loading state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case const (ErrorState):
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // Show popup error with "OK" button
            showPopup(context, getStateRendererType(), getMessage());
            // Return the content screen widget
            return contentScreenWidget;
          } else {
            // Full screen error state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case const (EmptyState):
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: () {});
        }
      case const (ContentState):
        {
          // Dismiss any open dialogs
          dismissDialog(context);
          // Return the content screen widget
          return contentScreenWidget;
        }
      case const (SuccessState):
        {
          // Dismiss any open dialogs (e.g., loading dialog)
          dismissDialog(context);
          // Show success popup
          showPopup(context, StateRendererType.popupSuccess, getMessage(),
              title: 'Success');
          // Return the content screen widget
          return contentScreenWidget;
        }
      default:
        {
          // Dismiss any open dialogs
          dismissDialog(context);
          // Return the content screen widget
          return contentScreenWidget;
        }
    }
  }

  bool _isCurrentDialogShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  void dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

showPopup(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = ''}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            title: title,
            retryActionFunction: () {}),
      ),
    );
  }
}
