class AdobePackager < Formula
  include Language::Python::Virtualenv

  desc "Download portable installers of different versions Adobe software"
  homepage "https://github.com/Drovosek01/adobe-packager"
  branch = "master"
  url "#{homepage}/archive/refs/heads/#{branch}.tar.gz"
  version "0.2.0"
  sha256 "85fb8cca08c15933f0f834acc8440f0059f3e1443c654afda41a40c3243b1b76"

  livecheck do
    url "#{@package_or_resource.homepage}/raw/refs/heads/#{branch}/ccdl.py"
    strategy :page_match
    regex(/\((\d+(?:\.\d+)+-?.*)\)/i)
  end

  depends_on "python3"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/e0/2d/a891ca51311197f6ad14a7ef42e2399f36cf2f9bd44752b3dc4eab60fdc5/certifi-2026.1.4.tar.gz"
    sha256 "ac726dd470482006e014ad384921ed6438c457018f4b3d204aea4281258b2120"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/f3/0d/f7b6ab21ec75897ed80c17d79b15951a719226b9fababf1e40ea74d69079/chardet-5.2.0.tar.gz"
    sha256 "1b3b6ff479a8c414bc3fa2c0852995695c4a026dcd6d0633b2dd092ca39c1cf7"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/6f/6d/0703ccc57f3a7233505399edb88de3cbd678da106337b9fcde432b65ed60/idna-3.11.tar.gz"
    sha256 "795dafcc9c04ed0c1fb032c2aa73654d8e8c5023a7df64a53f39190ada629902"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/ee/391076f5937f0a8cdf5e53b701ffc91753e87b07d66bae4a09aa671897bf/requests-2.28.2.tar.gz"
    sha256 "98b1b2782e3c6c4904938b84c0eb932721069dfdb9134313beff7c83c2df24bf"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/09/a9/6ba95a270c6f1fbcd8dac228323f2777d886cb206987444e4bce66338dd4/tqdm-4.67.3.tar.gz"
    sha256 "7d825f03f89244ef73f1d4ce193cb1774a8179fd96f31d7e1dcde62092b960bb"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e4/e8/6ff5e6bc22095cfc59b6ea711b687e2b7ed4bdb373f7eeec370a97d7392f/urllib3-1.26.20.tar.gz"
    sha256 "40c2dc0c681e47eb8f90e7e27bf6ff7df2e677421fd46756da1161c39ca70d32"
  end

  def install
    venv = virtualenv_create libexec, "python3"
    venv.pip_install resources
    libexec.install "ccdl.py" => @name
    (bin/@name).write_env_script libexec/@name, PYTHONPATH: venv.site_packages
  end

  test do
    output = shell_output("#{bin/@name} -h")
    assert_match(/#{version}.*show this help message and exit/m, output)
  end
end
