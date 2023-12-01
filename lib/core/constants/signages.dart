class Signage {
  String imgPath;
  String name;
  String description;

  Signage({required this.imgPath, required this.name, required this.description});
}

List<Signage> signages = [
  Signage(
    imgPath: "assets/trail_map/arrowsWhite.png",
    name: "DIRECTIONAL ARROWS",
    description: "Trails are one way unless specified.",
  ),
  Signage(
    imgPath: "assets/trail_map/greenDots.png",
    name: "GREEN DOTS",
    description: "indicate the recommended route for first-time visitors to TMBP.",
  ),
  Signage(
    imgPath: "assets/trail_map/yellowCircleIcon.png",
    name: "WAYFINDERS",
    description: "contain directional information and also indicate when trails merge or branch out.",
  ),
  Signage(
    imgPath: "assets/trail_map/CameraIcons.png",
    name: "Points of interest, rest stops & designated photo spots.",
    description: "These locations also contain airhorns for emergency signalling",
  ),
  Signage(
    imgPath: "assets/trail_map/berm.png",
    name: "BERM",
    description: "A berm is a gently-sloping embankment that allows riders to carry speed through a turn. Berms can go left or right.",
  ),
  Signage(
    imgPath: "assets/trail_map/drop.png",
    name: "DROP",
    description: "A feature with a significant loss of elevation. It typically has a flat take off, and vertical back side, that is not roll-able.",
  ),
  Signage(
    imgPath: "assets/trail_map/skinnies.png",
    name: "SKINNIES",
    description: "A raised trail feature that is narrow. This is a fun way to challenge someone's sense of balance.",
  ),
  Signage(
    imgPath: "assets/trail_map/rockies.png",
    name: "ROCKIES",
    description: "Also known a a rock garden. A natural arrangement of rocks of various sizes that riders must traverse.",
  ),
  Signage(
    imgPath: "assets/trail_map/rollers.png",
    name: "ROLLERS",
    description: 'A series of rolling "humps" that create a rhythm section that riders need to pump through.',
  ),
  Signage(
    imgPath: "assets/trail_map/tabletop.png",
    name: "TABLETOP",
    description: "A low consequence jumpable feature, which has a take off and landing, and a flat connecting section.",
  ),
  Signage(
    imgPath: "assets/trail_map/trails merge.png",
    name: "TRAILS MERGE",
    description: "This means that the current trail you are on merges with another one. Exercise caution when merging.",
  ),
  Signage(
    imgPath: "assets/trail_map/b line right.png",
    name: "B-LINE",
    description:
        "An alternate line that bypasses a particular trail feature. This allows riders a bail-out option if they are intimidated by the feature.",
  ),
  Signage(
    imgPath: "assets/trail_map/session spot launch pad.png",
    name: "SESSION SPOT",
    description:
        "This means that this particular line has a short trail that loops back to the start so riders can practice a feature. Only available in Skills Zone and at the start of Enter The Dragon at Launch Pad",
  ),
  Signage(
    imgPath: "assets/trail_map/no session.png",
    name: "NO SESSION",
    description: "This means that there is no Session Line on this trail. Once you are on the trail, you are committed to riding it till then end.",
  ),
  Signage(
    imgPath: "assets/trail_map/caution tile.png",
    name: "CAUTION",
    description: "This serves as an early-warning device for an upcoming trail feature. Please stay aware and alert.",
  ),
  Signage(
    imgPath: "assets/trail_map/keep clear.png",
    name: "KEEP CLEAR",
    description: "Please be aware that there are other riders on the trail. Keep clear of features and the trail for everyone's safety.",
  ),
  Signage(
    imgPath: "assets/trail_map/no loitering.png",
    name: "NO LOITERING",
    description: "Try to keep rest stops at a minimum, and avoid wandering off onto the rest of the forest.",
  ),
  Signage(
    imgPath: "assets/trail_map/one rider at a time 2 .png",
    name: "ONE RIDER AT A TIME",
    description: "As much as possible, wait for the rider in front of you to traverse the bridge or feature before entering yourself. ",
  ),
];
