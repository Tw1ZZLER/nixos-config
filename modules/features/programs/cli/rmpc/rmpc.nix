{
  self,
  inputs,
  ...
}: {
  flake.homeModules.rmpc = {pkgs, ...}: {
    home.packages = [pkgs.cava];

    # nord theme file
    xdg.configFile."rmpc/themes/nord.ron".source = ./nord.ron;

    programs.rmpc = {
      enable = true;

      # tabs config taken from https://rmpc.mierak.dev/themes/nord/
      config = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
            address: "${inputs.nix-secrets.ip-address.vpn.redmond}:6600",
            password: None,
            // Use the v0.11.0 nord theme docs — "Latest" uses unreleased Browser(levels)/Sticker APIs
            theme: Some("nord"),
            cache_dir: None,
            on_song_change: None,
            volume_step: 5,
            max_fps: 30,
            scrolloff: 0,
            wrap_navigation: false,
            enable_mouse: true,
            enable_config_hot_reload: true,
            select_current_song_on_change: false,
            browser_song_sort: [Disc, Track, Artist, Title],
            cava: (
                framerate: 60,
                autosens: true,
                sensitivity: 100,
                lower_cutoff_freq: 50,
                higher_cutoff_freq: 10000,
                input: (
                    method: Pipewire,
                    source: "auto",
                    sample_rate: 48000,
                    channels: 2,
                    sample_bits: 16,
                ),
                smoothing: (
                    noise_reduction: 77,
                    monstercat: false,
                    waves: false,
                ),
                eq: [],
            ),
            tabs: [
                (name: "Home", pane: Split(direction: Horizontal, panes: [
                    (size: "70%", borders: "NONE", pane: Split(direction: Vertical, panes: [
                        (size: "3", borders: "ALL", border_symbols: Rounded, pane: Pane(QueueHeader())),
                        (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Queue)),
                    ])),
                    (size: "30%", borders: "NONE", border_symbols: Rounded, pane: Split(direction: Vertical, panes: [
                        (size: "0.47r", borders: "TOP | RIGHT | LEFT",
                            border_symbols: Rounded,
                            pane: Pane(AlbumArt)
                        ),
                        (size: "100%", borders: "ALL",
                            border_symbols: Library("rounded_collapsed_top"),
                            border_title: [(kind: Text("Lyrics"), style: (fg: "#81a1c1"))],
                            border_title_position: Top,
                            border_title_alignment: Right,
                            pane: Pane(Lyrics)
                        ),
                    ])),
                ])),
                (name: "Directories", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Directories)),
                ])),
                (name: "Playlists", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Playlists)),
                ])),
                (name: "Artists", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Artists)),
                ])),
                (name: "Albums", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Albums)),
                ])),
                (name: "Album Artists", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(AlbumArtists)),
                ])),
                (name: "Genre", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Browser(root_tag: "genre", separator: ";"))),
                ])),
                (name: "Queue", pane: Split(direction: Vertical, panes: [
                    (size: "2", borders: "TOP | RIGHT | LEFT", border_symbols: Rounded, pane: Pane(QueueHeader())),
                    (size: "100%", borders: "ALL", border_symbols: Library("rounded_collapsed_top"),
                        border_title: [(kind: Property(Song(File)), style: (fg: "#4c566a"))],
                        border_title_position: Bottom,
                        border_title_alignment: Right,
                        pane: Pane(Queue)
                    ),
                ])),
                (name: "Cava", pane: Split(direction: Vertical, panes: [
                    (size: "50%", pane: Split(direction: Horizontal, panes: [
                        (size: "39%", borders: "ALL", border_symbols: Rounded, pane: Pane(Queue)),
                        (size: "22%", borders: "ALL", border_symbols: Rounded, pane: Pane(AlbumArt)),
                        (size: "39%", borders: "ALL",
                            border_title: [(kind: Text("Lyrics"), style: (fg: "#81a1c1"))],
                            border_title_position: Top,
                            border_title_alignment: Right,
                            border_symbols: Rounded,
                            pane: Pane(Lyrics)
                        ),
                    ])),
                    (size: "50%", borders: "ALL", border_symbols: Rounded, pane: Pane(Cava)),
                ])),
                (name: "Search", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Search)),
                ])),
            ],
        )
      '';
    };
  };
}
