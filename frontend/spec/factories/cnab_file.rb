FactoryBot.define do
  factory :cnab_file do
    status { :imported }

    file do
      ActionDispatch::Http::UploadedFile
        .new(
          tempfile: Rails.root.join('spec', 'fixtures', 'cnab.txt'),
          filename: 'cnab.txt'
        )
    end
  end
end
