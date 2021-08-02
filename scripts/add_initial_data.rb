# Use this script only once when launching the application.
# Usage: 
#   rails runner scripts/add_initial_data.rb RAILS_ENV=#{environment}

# initialize all logs
Log.destroy_all
ActiveRecord::Base.connection.execute('alter table logs auto_increment = 1;')

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
cp_2 = Log.create(
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
cobol_2 = Log.create(
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
go_2 = Log.create(
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
  ```
  package sample;
  public class SampleClass {
    public static void main(String[] args) {
      String buf = null;
      System.out.println("buf length is " + buf.length());
    }
  }
  ```
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
js_1 = Log.create(
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
js_2 = Log.create(
  error: error,
  languages: Language.where(name: "JavaScript"),
  solution: solution,
  title: 'Uncaught ReferenceError:',
  user_id: 1,
  release: true,
)

# Kotlin
error = <<~EOS
  初期値がないと言われた。
  Javaだとこれで動くんだけどな...。
  ```
  var message: TextView
  ```
EOS
solution = <<~EOS
  Kotlinでは初期値を書かなければいけないらしい。
  ```
  var message: TextView? = null
  ```
EOS
kotlin_1 = Log.create(
  error: error,
  languages: Language.where(name: "Kotlin"),
  solution: solution,
  title: '初期値未入力エラー',
  user_id: 1,
  release: true,
)

# Kuin
error = <<~EOS
  ブロック名に対応する「end」が存在しません...?
  ```
  0x0001000F
  class Parent()
    {
      処理A
    }
  end
  ```
EOS
solution = <<~EOS
  Kuinはendの後にブロックの種類を書く必要があるらしい
  ```
  ; OK!
  class Parent()
    {
      処理A
    }
  end class
  ```
EOS
kuin_1 = Log.create(
  error: error,
  languages: Language.where(name: "Kuin"),
  solution: solution,
  title: 'ブロック名に対応するendが存在しません。',
  user_id: 1,
  release: true,
)

# LISP
error = <<~EOS
Error: TYPE-ERROR :DATUM (CDR LT) :EXPECTED-TYPE FUNCTION
LISP全然わからん…
EOS
lisp_1 = Log.create(
  error: error,
  languages: Language.where(name: "LISP"),
  solution: nil,
  title: 'TYPE-ERROR :DATUM (CDR LT) :EXPECTED-TYPE FUNCTION',
  user_id: 1,
  release: true,
)
  
# MATLAB
error = <<~EOS
  Error using combinations (line 3)
  Cannot calculate with given values
  ```
  function com = combinations(a,b)
  if a > b
      error('Cannot calculate with given values')
  end
  com = factorial(a)/(factorial(b)*factorial(a-b));
  end

  combinations(4,8)
  ```
EOS
solution = <<~EOS
  combinationsの引数が無効だった。
  ```
  combinations(8,4)
  ```
  としたところエラーは起こらなかった。
EOS
mat_1 = Log.create(
  error: error,
  languages: Language.where(name: "MATLAB"),
  solution: solution,
  title: 'Cannot calculate with given values',
  user_id: 1,
  release: true,
)

# Node.js
error = <<~EOS
  npm installがうまくいかない。
  ```
  npm ERR! Failed at the node-sass@3.13.1 postinstall script.
  ```
EOS
solution = <<~EOS
  node.jsのversionが高すぎたのかもしれない。
  ```
  $ nodebrew ls-remote
  $ nodebrew install-binary v10.16.0
  $ nodebrew use v10.16.0
  $ node -v
  -> v 10.16.0
  ```
  以上の手順でダウングレードしたところ、npm installもうまくいった。
EOS
node_1 = Log.create(
  error: error,
  languages: Language.where(name: "Node.js"),
  solution: solution,
  title: 'npm installがうまくいかない',
  user_id: 1,
  release: true,
)

# PHP
error = <<~EOS
  Larabelにて以下のエラー。
  Parse error: syntax error, unexpected ‘{‘
  ```
  <?php
  $message = "Good";
  if(isset($message){
    echo $message;
  }
  ```
  { 入れるとこなんてある？
EOS
solution = <<~EOS
  if文の閉じ括弧が抜けていた。
  ```
  <?php
  $message = "Good";
  if(isset($message){
    echo $message;
  )}
  ```
EOS
php_1 = Log.create(
  error: error,
  languages: Language.where(name: "PHP"),
  solution: solution,
  title: "Parse error: syntax error, unexpected ‘{‘",
  user_id: 1,
  release: true,
)

# Perl
error = <<~EOS
  変数が未定義とのこと。
  ```
  num = 56
  print '$num\n'
  ```
  EOS
  solution = <<~EOS
  変数宣言時に$をつけ忘れていた。
  ```
  $num = 56
  print '$num\n'
  ```
  期待通りの結果が得られた。
EOS
perl_1 = Log.create(
  error: error,
  languages: Language.where(name: "Perl"),
  solution: solution,
  title: "変数宣言で'$'をつけ忘れたエラー",
  user_id: 1,
  release: true,
)

# Python
error = <<~EOS
  SyntaxError: unexpected indent
  ```
  def calc_liner(x,a,b):
    y = a * x + b
     return y
  ```
EOS
solution = <<~EOS
  return部分のインデントがずれていた。
  ```
  def calc_liner(x,a,b):
    y = a * x + b
    return y
  ```
  pythonはインデントに厳しい！
EOS
py_1 = Log.create(
  error: error,
  languages: Language.where(name: "Python"),
  solution: solution,
  title: "SyntaxError: unexpected indent",
  user_id: 1,
  release: true,
)

# R
error = <<~EOS
  ## Error: <text>:1:4: unexpected symbol
  ## 1: 1000m
  ```
  1000m <- "1km"
  ```
EOS
solution = <<~EOS
  数字で始まるオブジェクト名は作成できない。
  ```
  message <- "1km"
  ```
  これは大丈夫だった。
EOS
r_1 = Log.create(
  error: error,
  languages: Language.where(name: "R"),
  solution: solution,
  title: "Error: <text>:1:4: unexpected symbol",
  user_id: 1,
  release: true,
)

# Ruby
error = <<~EOS
  SassC::SyntaxError in Home#index
  ```
  @import "font-awesome-sprockets"
  ```
EOS
solution = <<~EOS
  gemfileに記述した後、bundle installをしていなかった。
  サーバーを止めて、bundle installした後に、rails sで起動したところ直った。
EOS
ruby_1 = Log.create(
  error: error,
  languages: Language.where(name: "Ruby"),
  solution: solution,
  title: "SassC::SyntaxError in Home#index",
  user_id: 1,
  release: true,
)

# Rust
error = <<~EOS
  error[E0308]: mismatched types
  ```
  use std::fs::File;
  fn main() {
      let f: u32 = File::open("hello.txt");
  }
  ```
  EOS
  solution = <<~EOS
  不要な型注釈をつけてしまっていた。
  ```
  use std::fs::File;
  fn main() {
      let f = File::open("hello.txt");
  }
  ```
  これで問題ない様子。
EOS
rust_1 = Log.create(
  error: error,
  languages: Language.where(name: "Rust"),
  solution: solution,
  title: "error[E0308]: mismatched types",
  user_id: 1,
  release: true,
)

# Scala
error = <<~EOS
  error: reassignment to val
  ```
  scala> val message = "Hello"
  message: java.lang.String = Hello
  scala> message = "Hi"
  <console>:8: error: reassignment to val
  message = "Hi"
  ```
  EOS
  solution = <<~EOS
  定数として宣言したmessageに再代入を試みていた。
  ```
  scala> val message = "Hello"
  message: java.lang.String = Hello
  scala> message = "Hi"
  message: java.lang.String = Hi
  ```
EOS
scala_1 = Log.create(
  error: error,
  languages: Language.where(name: "Scala"),
  solution: solution,
  title: "再代入しようとしてエラー",
  user_id: 1,
  release: true,
)

# Swift
error = <<~EOS
  Type annotation missing in pattern
  ```
  var message
  // Type annotation missing in pattern
  ```
EOS
solution = <<~EOS
  型の指定がないことが原因だった。
  ```
  var message: String
  message = "Hello"
  // もしくは
  var message:String = "Hello"
  ```
  でOKとのこと。
  型の推定機能もあるので、普通に
  ```
  var message = "Hello"
  ```
  でも。
EOS
swift_1 = Log.create(
  error: error,
  languages: Language.where(name: "Swift"),
  solution: solution,
  title: "Type annotation missing in pattern",
  user_id: 1,
  release: true,
)

# TypeScript
error = <<~EOS
  error: Type 'number' is not assignable to type 'string'.
  ```
  const limit: number = 10;
  const message: string = limit;
  ```
  EOS
  solution = <<~EOS
  すでに宣言済みのlimitをmessageに代入してしまっていた。
  ```
  const limit: number = 10;
  const message: string = "Hello";
  ```
EOS
ts_1 = Log.create(
  error: error,
  languages: Language.where(name: "TypeScript"),
  solution: solution,
  title: "error: Type 'number' is not assignable to type 'string'.",
  user_id: 1,
  release: true,
