import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vende_bet/data/datasources/sesion_datasource.dart';
import 'package:vende_bet/data/repositories/sesion_repository_impl.dart';

import '../../../domain/entities/sesion.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPress>(_onLoginPress);
  }

  final SesionRepositoryImpl _sesionRepositoryImpl = SesionRepositoryImpl(SesionDataSource());

  _onLoginPress(LoginPress event, Emitter<LoginState> emit) async{
    emit(LoginLoading());

    final voSalida = await _sesionRepositoryImpl.datasource.sesion(event.vcUser, event.vcPass);


    if(voSalida.vnCodigo == 1){
      emit(LoginOk(voSesion: voSalida.voData!));
    }else if(voSalida.vnCodigo == 0){
      emit(LoginError(vcMensaje: voSalida.vcMensaje?? 'Error inesperado'));
    }
  }

}