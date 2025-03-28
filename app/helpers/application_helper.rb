# frozen_string_literal: true

module ApplicationHelper
  # ページごとの完全なタイトルを返します。                   # コメント行
  # メソッド定義とオプション引数
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'  # 変数への代入
    if page_title.empty?                              # 論理値テスト
      base_title                                      # 暗黙の戻り値
    else
      "#{page_title} | #{base_title}"                 # 文字列の式展開
    end
  end
end
