import 'package:get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:storage/storage.dart';
import 'package:user/bloc/change_password/change_password_bloc.dart';
import 'package:user/bloc/manage_rss/manage_rss_bloc.dart';
import 'package:user/bloc/manage_tag/manage_tag_bloc.dart';
import 'package:user/bloc/menu/reading/reading_section_bloc.dart';
import 'package:user/bloc/menu/theme/theme_bloc.dart';
import 'package:user/repository/user_setting_repository.dart';
import 'package:user_api/user_api.dart';

import '../../bloc/delete_account/delete_account_bloc.dart';
import '../../repository/user_repository.dart';

class UserDI {
  static void setup() {
    GetIt.I.registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        client: HttpNetwork.client,
      ),
    );

    GetIt.I.registerFactory<ChangePasswordBloc>(
      () => ChangePasswordBloc(
        userRepository: GetIt.I.get(),
      ),
    );

    GetIt.I.registerFactory<DeleteAccountBloc>(
      () => DeleteAccountBloc(
        userRepository: GetIt.I.get(),
      ),
    );

    GetIt.I.registerSingletonAsync<UserSettingRepositoryApi>(
      () async => UserSettingRepositoryImpl(
        preferenceService: await SharedPreferenceService.instance(),
      ),
    );

    GetIt.I.registerFactory<ThemeBloc>(
      () => ThemeBloc(userSettingRepository: GetIt.I.get()),
    );

    GetIt.I.registerFactory<ReadingSectionBloc>(
      () => ReadingSectionBloc(
        userSettingRepository: GetIt.I.get(),
      ),
    );

    GetIt.I.registerFactory(
      () => ManageTagBloc(
        tagRepository: GetIt.I.get(),
      ),
    );

    GetIt.I.registerFactory(
      () => ManageRssBloc(
        rssRepository: GetIt.I.get(),
      ),
    );
  }
}
