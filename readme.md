1. Edit your home-manager to apply to your user so it build correctly

2. inside theme is _theme.nix you can see how I put together themes in a lego-like fashion with lib.mkMerge and combining attrsets
 - There are three themes:
 - The fallback theme is only there to prevent an error during build time. This error might be related to the issue.
    - removing the fallback assignment of stylix.image = fallback.stylix.image will throw the error.
 - the default theme after build will be in ./result/specialisation/default/
 - the alt theme is similar with ./result/specialisation/alt

3. in each specialisation and the parent you will notice home-files/stylix.md contain the same colormap despite having different generated palette in .config/stylix/generated.json
