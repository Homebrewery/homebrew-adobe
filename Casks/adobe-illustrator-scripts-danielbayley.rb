cask "adobe-illustrator-scripts-danielbayley" do
  version "2025.9.27,dbe1b35"
  sha256 "25881f30137cde59e0bd32aa7c0055dd21c0561d2960c802ac90b90a4f52a562"

  repo, dash, owner = token.rpartition "-"
  tokens = token.split dash

  author = "Daniel Bayley"
  repository = "github.com/#{owner}/#{repo}"
  branch = "main"
  app    = tokens.first(2).map(&:capitalize).join " "

  url "https://#{repository}/tarball/#{branch}"
  name tokens.first(3).map(&:capitalize).join " "
  desc "Handy scripts for #{app}"
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

  staged_path.glob("#{subpath}/*/*.jsx{,inc}", File::FNM_DOTMATCH).each do |path|
    base = path.relative_path_from(staged_path/subpath).to_s
    base = base.split("/").map(&:capitalize).join("/") unless base.end_with? ".jsxinc"

    artifact path, target: scripts/author/base
  end

  uninstall rmdir: scripts/author

  caveats do
    caskroom = staged_path/subpath
    license caskroom/"LICENSE.md"
    <<~EOS
      Read the manual at:
        #{caskroom}/README.md
    EOS
  end
end
