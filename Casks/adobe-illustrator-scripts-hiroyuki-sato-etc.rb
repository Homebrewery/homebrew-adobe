cask "adobe-illustrator-scripts-hiroyuki-sato-etc" do
  version "2018.8.2,4c3d1d6"
  sha256 "aca638f2fd50e3a776c0f503d3d79885581d9c565d1db9ecb5c6a9019d5c5868"

  author = "Hiroyuki Sato"
  owner  = "shspage"
  tokens = token.split "-"
  repo   = tokens[1..2].join "-"
  repository = "github.com/#{owner}/#{repo}"
  branch = "master"
  app    = tokens.first(2).map(&:capitalize).join " "

  url "https://#{repository}/tarball/#{branch}"
  name tokens[1..2].map(&:capitalize).join " "
  desc "JavaScript #{tokens.third} for #{app} CSx"
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
  subpath = "#{owner}-#{repo}-#{version.csv.second}"

  staged_path.glob("#{subpath}/{*,*/*}.jsx").each do
    target = scripts/author/it.basename.to_s
                              .split(/(?<=[a-z])(?=[A-Z])/)
                              .map(&:capitalize)
                              .join(" ")

    artifact it, target: target unless target.exist?
  end

  uninstall rmdir: scripts/author

  caveats do
    caskroom = staged_path/subpath
    license caskroom/"LICENSE.txt"
    <<~EOS
      Read the manuals at:
        #{caskroom}/readme.md
        #{caskroom}/etc/readme.md
    EOS
  end
end
