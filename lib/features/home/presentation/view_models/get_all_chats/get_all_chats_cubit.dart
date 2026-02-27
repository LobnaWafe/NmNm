import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_face/features/home/data/models/my_chats_model.dart';
import 'package:simple_face/features/home/repos/home_repo.dart';

part 'get_all_chats_state.dart';

class GetAllChatsCubit extends Cubit<GetAllChatsState> {
  GetAllChatsCubit(this.homeRepo) : super(GetAllChatsInitial());
    final HomeRepo homeRepo;

  Future<void> getAllChatsMethod({required String endPoint}) async {
    emit(GetAllChatsLoading());
    var data = await homeRepo.getAllChats(endPoint: endPoint);
    data.fold(
      (failure) {
        emit(GetAllChatsFailure(errorMsg: failure.errorMsg));
      },
      (chats) {
        emit(GetAllChatsSuccess(myChats: chats));
      },
    );
  }
}
