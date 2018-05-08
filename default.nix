{ solidityPackage, dappsys }: solidityPackage {
  name = "ds-value";
  deps = with dappsys; [ds-test ds-thing];
  src = ./src;
}
