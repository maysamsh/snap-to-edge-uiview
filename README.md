# Snap to edge for UIView

![snap_to_edges]https://github.com/maysamsh/snap-to-edge-uiview/blob/master/snap_to_edges.gif

For Tahrir I wanted to add a new feature in the new major update. I thought implementing a snap to edge might help users to align texts with each other, on small screen and with fingers it would be difficult without it.

The general idea is storing edges (`frame.origin`) of all existing views in an array, then calculate the distance of current view’s edges, which the user is moving, and if it’s smaller than a threshold you activate the snap.

The snap works, as you surely have noticed in apps like Instagram, like this: when the view gets near an edge it grips the edge until you push it further to release the grip and move freely again. Sounds simple, right?

You can read the acrticle at https://maysamsh.me/2020/03/14/snap-to-edge-for-uiview/
