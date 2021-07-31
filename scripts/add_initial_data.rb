# C Lang
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

# C#
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
# error = <<~EOS
#   
# EOS
# solution = <<~EOS
#   
# EOS
# cs_1 = Log.create(
#   error: error,
#   languages: Language.where(name: "C#"),
#   solution: solution,
#   title: '',
#   user_id: 1,
#   release: true,
# )

# C++
error = <<~EOS
  C2513.cpp エラー。該当コードは以下。
  int main(){
    int = 1;
  }
EOS
solution = <<~EOS
  変数名を書き忘れていた。
  int main(){
    int i = 1;
  }
  としたところ、エラーは解消した。
EOS
cp_1 = Log.create(
  error: error,
  languages: Language.where(name: "C++"),
  solution: solution,
  title: 'コンパイルエラー C2513',
  user_id: 1,
  release: true,
)
error = <<~EOS
  C2569.cpp エラー。コードは以下。
  union ubase{};
  class cHasPubBase : public ubase {};
EOS
solution = <<~EOS
  共用体は基底クラスとして使用できないとのこと。
  struct sbase{};
  class cHasPubBase : public sbase {};
  ↑のように構造体に変更する必要がある。
EOS
cp_1 = Log.create(
  error: error,
  languages: Language.where(name: "C++"),
  solution: solution,
  title: 'コンパイルエラー C2569 EnumOrUnion...',
  user_id: 1,
  release: true,
)

# COBOL
error = <<~EOS
  コンパイルエラー。
  変数が定義されていないとのこと。
  DATA DIVISION
    01 SUBSTRCT PIC 9(5).
  PROCEDURE DIVISION
    MOVE 1 TO SUBSTRACT.
EOS
solution = <<~EOS
  スペルミスが原因だった。
  DATA DIVISIONでSUBSTRCTとしていたところをSUBSTRACTとしたところ、エラーは解消した。
EOS
cobol_1 = Log.create(
  error: error,
  languages: Language.where(name: "COBOL"),
  solution: solution,
  title: 'スペルミスでコンパイルエラー',
  user_id: 1,
  release: true,
)
error = <<~EOS
  コンパイルエラー。ネストしたから？
  IF SUUJI1 > 2
  THEN
    IF SUUJI1 > 5
    THEN
      SUBTRACT 5 FROM SUUJI1
    ELSE
      ADD 1 TO SUUJI1
  END-IF.
EOS
solution = <<~EOS
  普通にケアレスミス。END IFを入れるのを忘れていた。
EOS
cp_1 = Log.create(
  error: error,
  languages: Language.where(name: "COBOL"),
  solution: solution,
  title: 'ENDIFを忘れてコンパイルエラー',
  user_id: 1,
  release: true,
)

# Go Lang
error = <<~EOS
  sample.go:6:syntax error: unexpected semicolon or newline before {
  package sample

  import "fmt"
  func sample()
  {
    fmt.Println("hello world!")
  }
EOS
solution = <<~EOS
  関数の開始中括弧を改行していたことが原因らしい。
  func sample(){
    fmt.Println("hello world!")
  }
  このようにしたら直った。
  構文チェックが厳しい笑
EOS
go_1 = Log.create(
  error: error,
  languages: Language.where(name: "Go"),
  solution: solution,
  title: 'unexpected samicolon or newline before',
  user_id: 1,
  release: true,
)
error = <<~EOS
  コンパイルエラー
  a := int(10)
  b := int64(5)
  b = a
EOS
solution = <<~EOS
  暗黙的に型を変換してしまっていた。
  a := int(10)
  b := int64(a)
  上記のようにしたところ、エラーは解消した。
EOS
go_1 = Log.create(
  error: error,
  languages: Language.where(name: "Go"),
  solution: solution,
  title: '暗黙的な型変換でコンパイルエラー',
  user_id: 1,
  release: true,
)

# Java
error = <<~EOS
  Exception in thread "main" java.lang.NullPointerException.
  -- code ---
  package sample;
  public class SampleClass {
    public static void main(String[] args) {
      String buf = null;
      System.out.println("buf length is " + buf.length());
    }
  }
  -----------
EOS
solution = <<~EOS
  "NullPo!"
  package sample;
  public class SampleClass {
    public static void main(String[] args) {
      String buf = hoge;
      System.out.println("buf length is " + buf.length());
    }
  }
  it works.
EOS
java_1 = Log.create(
  error: error,
  languages: Language.where(name: "Java"),
  solution: solution,
  title: 'Exception in thread "main" java.lang.NullPointerException',
  user_id: 1,
  release: true,
)
error = <<~EOS
  Exception in thread "main" java.lang.ArithmeticException: / by zero
  package sample;
  public class SampleClass {
    public static void main(String[] args) {
      int valueA;
      int valueB;
      int result;

      valueA = 1;
      valueB = 0;
      result = valueA / valueB;
    }
  }
EOS
solution = <<~EOS
  1 ÷ 0 ってそりゃできるわけないか…。
  いわゆるゼロ除算というものらしい。
EOS
java_2 = Log.create(
  error: error,
  languages: Language.where(name: "Java"),
  solution: solution,
  title: 'java.lang.ArithmeticException',
  user_id: 1,
  release: true,
)

# Javascript
error = <<~EOS
  Uncaught SyntaxError: Unexpected end of input
  ```
  function myFunc() {
    if(true) {
        console.log('Helllo');
    }
  ```
  end of input っていうけどend入れるようなところはないぞ？
EOS
solution = <<~EOS
  閉じカッコがなかった。
  ```
  function myFunc() {
    if(true) {
        console.log('Helllo');
    }
  end
  ```
  これでOK。
EOS
js = Log.create(
  error: error,
  languages: Language.where(name: "JavaScript"),
  solution: solution,
  title: 'Uncaught SyntaxError: Unexpected end of input',
  user_id: 1,
  release: true,
)
error = <<~EOS
  Uncaught ReferenceError: morningGreet is not defined
  ```
  const moningGreet = 'Hello!';
  console.log(morningGreet);
  ```
EOS
solution = <<~EOS
  関数の宣言時に名前を間違えていた。
  ```
  const moningGreet = 'Hello!';
  console.log(morningGreet);
  ```
  タイポォぉぉ！
EOS
js = Log.create(
  error: error,
  languages: Language.where(name: "JavaScript"),
  solution: solution,
  title: 'Uncaught ReferenceError:',
  user_id: 1,
  release: true,
)

# Kotlin


