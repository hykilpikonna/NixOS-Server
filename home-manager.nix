let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    # rev = "dd94a849df69fe62fe2cb23a74c2b9330f1189ed"; # the commit to fetch
    ref = "release-21.05"; # the branch to follow: release-xx.yy for stable nixos or master for nixos-unstable.
  };
  hydev-server-setup = builtins.fetchGit {
    url = "https://github.com/hykilpikonna/HyServerSetup.git";
    ref = "master";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.root = {

    # Git
    programs.git = {
      enable = true;
      userName = "Hykilpikonna";
      userEmail = "me@hydev.org";
    };

    programs.bash = {
      enable = true;
      bashrcExtra = ''
        export SCR="${hydev-server-setup}/scripts"
        source "$SCR/bashrc";
	source "$SCR/bashrc-nix.sh"
      '';
    };
  };
}
