# flutternewsapp

Flutterで作成したニュースのデモアプリです。

newsapi.orgのAPI経由でニュース情報を取得しています。

## キャプチャ

<img src="https://github.com/user-attachments/assets/71f6e3cf-fb61-432c-9b0d-97ac32fe373d" width="300" />

<img src="https://github.com/user-attachments/assets/7845b064-5bcc-46ae-821e-b7066035b7e1" width="300" /> <img src="https://github.com/user-attachments/assets/b9ef6a65-0a72-4875-bc66-cda85cac10c0" width="300" />

<img src="https://github.com/user-attachments/assets/e5925a77-b878-4596-b744-1fdb7929f2fb" width="300" /> <img src="https://github.com/user-attachments/assets/126ef62e-26e3-418d-9b53-4ccfc77cb33d" width="300" />


## 機能

- ニュースヘッドラインの表示
- ニュースのキーワード検索
- ニュース記事の表示
- お気に入り登録

## 動作環境

Android, iOS




## ライブラリ

### ファイル自動生成

```
dart pub add dev:build_runner
```

### HTTPクライアント

```
flutter pub add dio
flutter pub add retrofit
dart pub add retrofit_generator

# Retrofit用のクラスを更新したら自動生成を実行
dart run build_runner build
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

### path

```
flutter pub add path
```

### DB

```
flutter pub add sqflite
```
### DateFormat

```
flutter pub get
```

### packageInfo

```
flutter pub add package_info_plus
```

### 環境変数

```
flutter pub add envied
flutter pub add --dev envied_generator

# .envとlib/env/env.dartを追加した後に実行
dart run build_runner build
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
