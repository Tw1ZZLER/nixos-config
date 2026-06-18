# Cursor, AI powered IDE
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.cursor = {...}: {
    programs.cursor.enable = true;
  };
}
