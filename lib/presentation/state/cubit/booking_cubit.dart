import 'package:flutter_bloc/flutter_bloc.dart';

class BookingState {
  final int currentStep;
  final Map<String, dynamic> data;
  final Set<String> loadingReports;

  BookingState({
    required this.currentStep,
    required this.data,
    this.loadingReports = const {},
  });

  BookingState copyWith({
    int? currentStep,
    Map<String, dynamic>? data,
    Set<String>? loadingReports,
  }) {
    return BookingState(
      currentStep: currentStep ?? this.currentStep,
      data: data ?? this.data,
      loadingReports: loadingReports ?? this.loadingReports,
    );
  }
}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingState(currentStep: 1, data: {}));

  void nextStep() {
    final next = state.currentStep + 1;
    if (next <= 7) {
      emit(state.copyWith(currentStep: next));
    }
  }

  void previousStep() {
    final prev = state.currentStep - 1;
    if (prev >= 1) {
      emit(state.copyWith(currentStep: prev));
    }
  }

  void updateBookingData(Map<String, dynamic> patch) {
    final merged = Map<String, dynamic>.from(state.data)..addAll(patch);
    emit(state.copyWith(data: merged));
  }

  Future<void> addFiles(String reportKey, List<dynamic> files) async {
    // Set loading state
    final newLoading = Set<String>.from(state.loadingReports)..add(reportKey);
    emit(state.copyWith(loadingReports: newLoading));

    // Simulate network/processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Add files
    final currentFilesMap = Map<String, dynamic>.from(state.data['files'] ?? {});
    currentFilesMap[reportKey] = files;
    
    // Remove loading state and update data
    final finishedLoading = Set<String>.from(state.loadingReports)..remove(reportKey);
    emit(state.copyWith(
      data: Map<String, dynamic>.from(state.data)..addAll({'files': currentFilesMap}),
      loadingReports: finishedLoading,
    ));
  }

  void clearFiles(String reportKey) {
    final currentFilesMap = Map<String, dynamic>.from(state.data['files'] ?? {});
    currentFilesMap.remove(reportKey);
    updateBookingData({'files': currentFilesMap});
  }
}
