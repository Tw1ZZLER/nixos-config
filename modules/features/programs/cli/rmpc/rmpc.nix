{
  self,
  inputs,
  ...
}: {
  flake.homeModules.rmpc = {pkgs, ...}: {
    home.packages = [pkgs.cava];

    programs.rmpc = {
      enable = true;

      xdg.configFile."rmpc/themes/nord.ron".source = ./nord.ron;

      # tabs config taken from https://rmpc.mierak.dev/themes/nord/
      config = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
            address: "${inputs.nix-secrets.ip-address.vpn.redmond}:6600",
            password: None,
            theme: None,
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
                    (size: "65%", borders: "NONE", pane: Split(direction: Vertical, panes: [
                        (size: "3", borders: "ALL", border_symbols: Rounded , pane: Pane(QueueHeader())),
                        (size: "100%", borders: "ALL", border_symbols: Rounded ,pane: Pane(Queue)),
                    ])),
                    (size: "35%", borders: "NONE", border_symbols: Rounded ,pane: Split(direction: Vertical, panes: [
                        (size: "0.47r", borders: "TOP | RIGHT | LEFT",
                            border_symbols: Rounded,
                            pane: Pane(AlbumArt)
                        ),
                        (size: "100%", borders: "ALL",
                            border_symbols: Library("rounded_collapsed_top"),
                            border_title: [
                                (kind: Text("┐"), style: (fg: "#81a1c1")),
                                (kind: Text("Lyrics"), style: (fg: "#81a1c1")),
                                (kind: Text("┌"), style: (fg: "#81a1c1")),
                            ],
                            border_title_position: Top,
                            border_title_alignment: Right,
                            pane: Pane(Lyrics)
                        ),
                    ])),
                ])),
                (name: "Directories", pane: Split(direction: Horizontal,panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Directories)),
                ])),
                (name: "Playlists", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Playlists)),
                ])),
                (name: "Artists", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Browser(
                        levels: [
                            (group_by: [[Artist]],
                                skip: SingleEmpty,
                            ),
                            (group_by: [[Album], [Other("date"), Other("originaldate")]],
                                format: [
                                    (kind: Group([
                                        (kind: Text("(")),
                                        (kind: Property(Other("date"))),
                                        (kind: Text(") ")),
                                    ])),
                                    (kind: Property(Album)),
                                ],
                            ),
                        ],
                    ))),
                ])),
                (name: "Albums", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Browser(
                        levels: [
                            (group_by: [[Album]]),
                        ],
                    ))),
                ])),
                (name: "Album Artists", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Browser(
                        levels: [
                            (
                                group_by: [[AlbumArtist]],
                                sort_by: [[AlbumArtist]],
                                format: [
                                    (kind: Property(AlbumArtist), default: (kind: Text("<no albumartist>"))),
                                ],
                            ),
                            (
                                group_by: [[Album], [Other("date"), Other("originaldate")]],
                                format: [
                                    (kind: Group([
                                        (kind: Text("(")),
                                        (kind: Property(Other("date"))),
                                        (kind: Text(") ")),
                                    ])),
                                    (kind: Property(Album)),
                                ],
                                skip: UnpackEmpty,
                            ),
                        ],
                    ))),
                ])),
                (name: "Composer", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Browser(
                        levels: [
                            (group_by: [[Other("composer")]]),
                            (group_by: [[Album], [Other("date"), Other("originaldate")]],
                                format: [
                                    (kind: Group([
                                        (kind: Text("(")),
                                        (kind: Property(Other("date"))),
                                        (kind: Text(") ")),
                                    ])),
                                    (kind: Property(Album)),
                                ],
                            ),
                        ],
                    ))),
                ])),
                (name: "Genre", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded, pane: Pane(Browser(
                        levels: [
                            (group_by: [[Other("genre")]]),
                            (group_by: [[AlbumArtist, Artist]],
                                sort_by: [[AlbumArtist, Artist]],
                                format: [
                                    (kind: Property(AlbumArtist), default: (kind: Property(Artist), default: (kind: Text("no artist")))),
                                ],
                                skip: SingleEmpty,
                            ),
                            (group_by: [[Album], [Other("date"), Other("originaldate")]],
                                format: [
                                    (kind: Group([
                                        (kind: Text("(")),
                                        (kind: Property(Other("date"))),
                                        (kind: Text(") ")),
                                    ])),
                                    (kind: Property(Album)),
                                ],
                                skip: UnpackEmpty,
                            ),
                        ],
                    ))),
                ])),
                (name: "Queue", pane: Split(direction: Vertical, panes: [
                    (size: "2", borders: "TOP | RIGHT | LEFT", border_symbols: Rounded, pane: Pane(QueueHeader())),
                    (size: "100%", borders: "ALL", border_symbols: Library("rounded_collapsed_top"),
                        border_title: [
                            (kind: Text("● "), style: (fg: "#81a1c1")),
                            (kind: Property(Song(File)), style: (fg: "#4c566a")),
                            (kind: Text(" ●─"), style: (fg: "#81a1c1")),
                        ],
                        border_title_position: Bottom,
                        border_title_alignment: Right,
                        pane: Pane(Queue)
                    ),
                ])),
                (name: "Cava",pane: Split(direction: Vertical, panes: [
                    (size: "50%", pane: Split(direction: Horizontal, panes: [
                        (size: "39%", borders: "ALL", border_symbols: Rounded, pane: Pane(Queue)),
                        (size: "22%", borders: "ALL", border_symbols: Rounded, pane: Pane(AlbumArt)),
                        (size: "39%", borders: "ALL",
                            border_title: [
                                (kind: Text("┐"), style: (fg: "#81a1c1")),
                                (kind: Text("Lyrics"), style: (fg: "#81a1c1")),
                                (kind: Text("┌─"), style: (fg: "#81a1c1")),
                            ],
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
                (name: "History", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded,
                        border_title: [
                            (kind: Text("[ "), style: (fg: "#81a1c1")),
                            (kind: Text("History"), style: (fg: "#d8dee9")),
                            (kind: Text(" ]"), style: (fg: "#81a1c1")),
                        ],
                        border_title_position: Top,
                        border_title_alignment: Center,
                        pane: Pane(Sticker(
                            sticker: "lastPlayed",
                            sort: ValueIntDesc,
                            limit: Some(10),
                            format: [
                                (kind: Property(Artist), default: (kind: Text("Unknown Artist"))),
                                (kind: Text(" - ")),
                                (kind: Property(Title), default: (kind: Text("Unknown Title"))),
                            ],
                        ))
                    ),
                ])),
                (name: "Most Played", pane: Split(direction: Horizontal, panes: [
                    (size: "100%", borders: "ALL", border_symbols: Rounded,
                        border_title: [
                            (kind: Text("[ "), style: (fg: "#81a1c1")),
                            (kind: Text("Most Played"), style: (fg: "#d8dee9")),
                            (kind: Text(" ]"), style: (fg: "#81a1c1")),
                        ],
                        border_title_position: Top,
                        border_title_alignment: Center,
                        pane: Pane(Sticker(
                            sticker: "playCount",
                            sort: ValueIntDesc,
                            limit: Some(50),
                            format: [
                                (kind: Property(Artist), default: (kind: Text("Unknown Artist"))),
                                (kind: Text(" - ")),
                                (kind: Property(Title), default: (kind: Text("Unknown Title"))),
                            ],
                        ))
                    )
                ])),
            ],
        )
      '';
    };
  };
}
