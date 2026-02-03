cask "adobe-illustrator-scripts-sergey-osokin" do
  version "2026.1.23,48de0ff"
  sha256 "5d9e5d529d045a759067d4bcbe12c0bf3c8a36844a012eac728f57df6c2eb25b"

  language "ru" do
    ".ru"
  end
  language "en", default: true do
    "[^.][^r][^u]"
  end

  author = "Sergey Osokin"
  owner  = "creold"
  tokens = token.split "-"
  repo   = tokens[1..2].join "-"
  repository = "github.com/#{owner}/#{repo}"
  branch = "master"
  app    = tokens.first(2).map(&:capitalize).join " "

  url "https://#{repository}/tarball/#{branch}"
  name tokens.first(3).map(&:capitalize).join " "
  desc "Some powerful JSX scripts for extending #{app}"
  homepage "https://#{repository}#readme"

  livecheck do
    url "https://#{repository}/commits"
    months = Regexp.union Date::ABBR_MONTHNAMES.compact
    regex(/>.*?(#{months}\s+\d{1,2},\s+\d{4})<.*?>(\h{7})</)
    strategy :page_match   do |page, regex|
      page.scan(regex).map do |(date, commit_hash)|
        date = Date.parse date
        date = date.strftime "%Y.%-m.%d"
        "#{date},#{commit_hash}"
      end
    end
  end

  year = "[0-9]" * 4
  scripts = appdir.glob("#{app} #{year}/Presets.localized/*/Scripts").max
  subpath = "#{owner}-#{repo}-#{version.after_comma}"

  staged_path.glob("#{subpath}/*/*.jsx").each do |path|
    artifact path, target: scripts/author/path.basename
  end

  caveats do
    caskroom = staged_path/subpath
    license caskroom/"LICENSE"

    docs = caskroom.glob("md/*#{language}.md").reduce("") do |text, path|
      text + "#{path.each_filename.to_a.last(2).join "/"}\n  "
    end
    <<~EOS
      Read the manuals at:
        #{caskroom.glob("REA*#{language}.md").first}
        #{docs}
    EOS
  end
end
