# flutternewsapp

News App.

## Getting Started

## ライブラリインストール

### dartバージョン

### ファイル自動生成

```
dart pub add dev:build_runner
```

### HTTPクライアント

```
flutter pub add dio
flutter pub add retrofit
```

### jsonシリアライズ

```
flutter pub add json_annotation
dart pub add dev:json_serializable
```

### ログ

```
flutter pub add logger
```

### immutableクラス生成

```
dart pub add freezed
flutter pub add freezed_annotation
```

### 環境変数

```
flutter pub add envied
flutter pub add --dev envied_generator
```

### flutterバージョン管理

```
brew tap leoafarias/fvm
brew install fvm
fvm relases
fvm use 3.24.5
```

### javaバージョン管理

```
brew install jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ~/.zshrc
jenv enable-plugin export
exec $SHELL -l

brew install openjdk@17
sudo ln -sfn /usr/local/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
echo 'export PATH="/usr/local/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
jenv add `/usr/libexec/java_home -v "17"`
java local 17
```
