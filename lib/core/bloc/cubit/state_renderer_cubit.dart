import 'package:bloc/bloc.dart';

import '../../helper/state_renderer/state_rendere_impl.dart';
import '../../helper/state_renderer/state_renderer.dart';

abstract class BaseQubit extends Cubit<FlowState> {
  Future<void> Function()? _lastOperation;

  BaseQubit() : super(ContentState());

  void showLoading({bool isPopup = false}) {
    emit(LoadingState(
      stateRendererType: isPopup
          ? StateRendererType.popupLoadingState
          : StateRendererType.fullScreenLoadingState,
    ));
  }

  void showError(String message, {bool isPopup = false}) {
    emit(ErrorState(
      isPopup
          ? StateRendererType.popupErrorState
          : StateRendererType.fullScreenErrorState,
      message,
    ));
  }

  void showSuccess(String message) => emit(SuccessState(message));

  void showContent() => emit(ContentState());

  void showEmpty(String message) => emit(EmptyState(message));

  Future<void> handleAsyncOperation<T>({
    required Future<T> Function() operation,
    required Function(T data) onSuccess,
    Function(dynamic error)? onError,
    bool showLoadingPopup = false,
  }) async {
    if (isClosed) return;
    
    _lastOperation = () => handleAsyncOperation(
          operation: operation,
          onSuccess: onSuccess,
          onError: onError,
          showLoadingPopup: showLoadingPopup,
        );

    showLoading(isPopup: showLoadingPopup);

    try {
      final result = await operation();
      if (isClosed) return;
      onSuccess(result);
      showContent();
    } catch (e) {
      if (isClosed) return;
      onError?.call(e);
      showError(e.toString(), isPopup: showLoadingPopup);
    }
  }

  void retryLastAction() {
    if (!isClosed && _lastOperation != null) {
      _lastOperation!();
    }
  }

  @override
  Future<void> close() {
    _lastOperation = null;
    return super.close();
  }
}