import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/features/home/data/models/users_system_mode.dart';
import 'package:simple_face/features/home/repos/home_repo.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit(this.homeRepo) : super(GetAllUsersInitial());
  final HomeRepo homeRepo;

  Future<void> getAllUsersMethod({required String endPoint}) async {
    emit(GetAllUsersLoading());
    var data = await homeRepo.getAllUsers(endPoint: endPoint);
    data.fold(
      (failure) {
        emit(GetAllUsersFailure(errorMsg: failure.errorMsg));
      },
      (users) {
        emit(GetAllUsersSuccess(users: users));
      },
    );
  }
}
