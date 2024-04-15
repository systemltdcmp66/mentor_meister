import 'package:bloc/bloc.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/cache_first_timer.dart';
import 'package:mentormeister/features/Onboarding&Authentication/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:mentormeister/features/Onboarding&Authentication/presentation/app/on_boarding_cubit/on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(
          const OnBoardingInitial(),
        );

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cacheFirstTimer();

    result.fold(
      (failure) => emit(
        OnBoardingError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const UserCached(),
      ),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());

    final result = await _checkIfUserIsFirstTimer();

    result.fold(
      (_) => emit(
        const OnBoardingStatus(
          isFirstTimer: true,
        ),
      ),
      (isFirstTimer) => emit(
        OnBoardingStatus(
          isFirstTimer: isFirstTimer,
        ),
      ),
    );
  }
}
