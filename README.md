# 事前準備
- ArtifactRegistryを有効化
- Workload Identity 連携を有効化
  - 有効化ボタンではなく「使ってみる」ボタンを押すことで有効化できる
- Identity and Access Management (IAM) APIを有効化
- Cloud SQL Admin APIを有効化
- Compute Engine APIを有効化
- Service Networking APIを有効化
- Secret Manager APIを有効化
  - 有効化ボタンではなく「管理」ボタンを押すことで有効化できる
- Kubernetes Engine APIを有効化
- Terraform用のサービスアカウントに付与するロール
  - Artifact Registry 管理者
  - IAM Workload Identity プール管理者
  - 閲覧者
  - サービス アカウント管理者
  - Project IAM 管理者
  - Cloud SQL 管理者
  - DNS 管理者
  - Compute ネットワーク管理者
  - storage.buckets.create + storage.buckets.update + storage.buckets.delete + storage.buckets.getIamPolicy + storage.buckets.setIamPolicy（カスタムロール）
  - Secret Manager 管理者
  - Secret Managerのシークレットバージョンのマネージャー
  - compute.sslCertificates.create + compute.sslCertificates.delete（カスタムロール）
  - Kubernetes Engine 管理者
  - サービス アカウント ユーザー
  - ※ 最小限のロール付与で済むようカスタムロールを作成したりしている。カスタムロールの付与がうまくいかなかった場合、普通に既存のロール付与
    - 既存のロールだと過剰に権限がつくのでうまいことカスタムロールで収めたいところ・・・

# セットアップ手順
### 初期化
``` shell
terraform init
```

※ 下記のようなエラーが出た場合は再度ログイン  
`Error: storage.NewClient() failed: dialing: google: could not find default credentials.`
``` shell
gcloud auth application-default login
```

### リソース適用
``` shell
terraform apply
```

### 構成ファイル指定で適用
``` shell
terraform apply `cat ./iam_service_account.tf | terraform fmt - | grep -E 'resource |module ' | tr -d '"' | awk '{printf("-target=%s.%s ", $2,$3);}'`
```
