let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    # rev = "dd94a849df69fe62fe2cb23a74c2b9330f1189ed"; # the commit to fetch
    ref = "release-21.05"; # the branch to follow: release-xx.yy for stable nixos or master for nixos-unstable.
  };
  hydev-server-setup = builtins.fetchGit {
    url = "https://github.com/hykilpikonna/HyServerSetup.git";
    rev = "14a6e98dcb6c9d594ce594ce7fc214a8e44e21d3";
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
    
    # Bash
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        export SCR="${hydev-server-setup}/scripts"
        source "$SCR/bashrc";
      	source "$SCR/bashrc-nix.sh"
      '';
    };

    # SSH
    home.file.".ssh/id_rsa.pub".text = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCy3+c09vunThjhW4tHJyNP9chQh0SKt6Ot3g3d2YpKbJhT6eKCY5vDXUVPrEYJkNt4LoOTemsG6gysGl5ulK5biRSqCb4wPa5qWUNbJ7Q8tEGoRPo6n3mNndYXII2QZBnyF+MiwE/VUG3gab+PUGl19olD5bOqwjwKMR0EPV6rlhZasOpNFmZu2qVknPH8BP626gfQzQ6/KQc9/98KOO2bFBNTXJVaPaHsQjT+jFU7zuVzQYjWQMORv+Zg3W6cAm8TTVOC51qlA/zhgisd0r8aUNUCk3ApycTZ/ImIxXqKev5amTVYbExjsu0xl3orvKUx+Pd6T3avOZJbF2Q1vQvAz608vn0a9H/C6aafa0Mrly6tVDB6Tj+ujoIsh7dsyTr7n0J6HZLlpK1KAM0ryJIDUiUKfHFCB0uFIjAvVAJu2thtB8ag7BLP6qsE6+BnCFsgSeCipmCk1HEsMCyvLcP9O2oHai3ErraC7LusnNeKwmc5PBqOpSG/oSMJtPqUE6U= me@hydev.org";
  };
}
