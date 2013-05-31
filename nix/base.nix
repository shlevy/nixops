{ lib, ... }:
let
  inherit (lib) mkOption;

  inherit (lib.types) attrsOf optionSet string bool;
in {
  options = {
    resources = {
      machines = mkOption {
        description = "The machines in the network";

        type = attrsOf optionSet;

        options.imports = import <nixos/modules/module-list.nix>;
      };

      ec2KeyPairs = mkOption {
        description = "The EC2 key pairs in the network";

        type = attrsOf optionSet;

        options.imports = ./ec2-keypair.nix;
      };

      s3Buckets = mkOption {
        description = "The S3 buckets in the network";

        type = attrsOf optionSet;

        options.imports = ./s3-bucket.nix;
      };

      iamRoles = mkOption {
        description = "The IAM roles in the network";

        type = attrsOf optionSet;

        options.imports = ./iam-role.nix;
      };
    };

    network = {
      description = mkOption {
        description = "The description of the network";

        default = "Unnamed NixOps network";

        type = string;
      };

      enableRollback = mkOption {
        description = "Whether to enable rollback for the network";

        default = false;

        type = bool;
      };
    };
  };
}
