class DefineLanguages < ActiveRecord::Migration[6.1]
  def change
    Language.delete_all
    ActiveRecord::Base.connection.execute('alter table languages auto_increment = 1;')

    languages = ["C", "C#", "C++", "COBOL", "Go", "Java", "JavaScript", "Kotlin", "Kuin", "LISP", "MATLAB", "Node.js", "PHP", "Perl", "Python", "R", "Ruby", "Rust", "Scala", "Swift", "TypeScript", "VisualBasic.NET"]
    languages.each do |language|
      Language.create(name: language)
    end
  end
end
