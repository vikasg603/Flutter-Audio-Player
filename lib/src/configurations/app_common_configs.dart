import 'dart:async';

import 'package:flutter_audio_player/src/app/app.dart';
import 'package:flutter_audio_player/src/app/common/blocs/app_bloc_delegate.dart';
import 'package:flutter_audio_player/src/app/features/audio_player/blocs/blocs.dart';
import 'package:flutter_audio_player/src/app/features/explore/blocs/blocs.dart';
import 'package:flutter_audio_player/src/configurations/environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void configureApp() {
  WidgetsFlutterBinding.ensureInitialized();

  runZoned<Future<void>>(
    () async {
      Current = await Environment.current();

      BlocSupervisor.delegate = AppBlocDelegate();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ExploreBloc>(
              create: (context) => ExploreBloc(),
            ),
            BlocProvider<AudioPlayerBloc>(
              create: (context) => AudioPlayerBloc(),
            ),
          ],
          child: const App(),
        ),
      );
    },
  );
}
