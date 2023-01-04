require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full_titleメソッドのテスト" do
    context "特定のタイトルを指定した場合（引数が指定された場合）" do
      it "「引数 - BIGBAG Store」を出力すること" do
        expect(helper.full_title("product_name")).to eq "product_name - BIGBAG Store"
      end
    end

    context "特定のタイトルを指定しない場合(引数がnilの場合)" do
      it "「BIGBAG Store」を出力すること" do
        expect(helper.full_title(nil)).to eq "BIGBAG Store"
      end
    end

    context "特定のタイトルを指定しない場合(引数が空文字の場合)" do
      it "「BIGBAG Store」を出力すること" do
        expect(helper.full_title("")).to eq "BIGBAG Store"
      end
    end
  end
end
