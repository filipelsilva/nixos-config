let
  Y540 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEq7vY6uC3fO/XRiu4H30I6wNBduHFfSmqWrguigrxap Y540";
  T490 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjqkOHYodMjourMLlNaCJLCE6f8rzkguRd16YTUU164 T490";
  N100 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDO1MtviYyp8XTpV1i8PwiRkKu/4hmUQ9zWZM5UsLFG2 N100";

  hosts = [Y540 T490 N100];
in {
  "cloudflare-dns-api-token.age".publicKeys = [N100];
  "N100-wg-private-key.age".publicKeys = [N100];
  "Y540-wg-private-key.age".publicKeys = [Y540];
  "T490-wg-private-key.age".publicKeys = [T490];
}
