# C lang
c_1 = Log.create(
  user_id: 1,
  title: "No such file or directory",
  error: "No such file or directory hogehoge.
hogehogeディレクトリがありませんと怒られた。",
  solution: "ディレクトリを見直したところ、hogehugaディレクトリとなっていた。
ディレクトリ名をhogehogeに変更したところ、エラーは解消した。",
  languages: Language.where(name: "C"),
  release: true,
)
error = <<~EOS
  prompt > gcc a.c
  a.c: In function `main':
  a.c:6: error: syntax error before 'printif'
  コードは以下の通り
  main(){
    int i
    printf("%f",2.0);
  }
EOS
solution = <<~EOS
  int i の後に「;」をつけ忘れていた。
  int i;としたことで、エラーは解消した。
EOS
c_2 = Log.create(
  user_id: 1,
  error: error,
  title: 'syntax error before "printf"',
  solution: solution,
  languages: Language.where(name: "C"),
  release: true,
)

# C# lang
error = <<~EOS
  Index was out of range.
  インデックスは配列の範囲外ですと怒られた。該当のコードは以下の通り。
  int[] array = { 1, 2, 3 }
  int num = array[3];
EOS
solution = <<~EOS
  indexが0から始まることを知らなかった…
  参照したいのは3番目の数字だったので、array[2]としたところエラーは解消した。
EOS
cs_1 = Log.create(
  error: error,
  languages: Language.where(name: "C#"),
  solution: solution,
  title: 'Index was out of range. Must be non-negative...',
  user_id: 1,
  release: true,
)

