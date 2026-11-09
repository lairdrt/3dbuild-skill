# From CAD to an actual print

This guide comes into play when a design reaches print-candidate status. Don't front-load a dozen checks onto an early conceptual iteration.

## Model/source checks

- `.scad` is the editable **parametric source**, normally developed and committed by the chat assistant.
- Use consistent millimeter units and known reference datums. Verify the expected outer envelope and important clear openings against measured dimensions.
- In OpenSCAD, **F5 previews** and **F6 renders**. Watch the error/warning console for missing modules, invalid operations, CGAL errors or unexpected pieces.
- Export an STL with OpenSCAD **File → Export → Export as STL** (or `openscad -o exports/part-v1.stl src/part.scad` when CLI tooling is available). The exported file must correspond to the **committed source revision**.
- When available, use an established mesh checker (`trimesh`, MeshLab, slicer's mesh repair/analysis) to check extents, watertightness, winding, unexpected bodies and tiny disconnected solids. These are geometry checks, **not physical-fit proof**.

Optional independent validation:

```python
import trimesh
m = trimesh.load_mesh("exports/part-v1.stl", force="mesh")
print("size mm:", m.extents)
print("watertight:", m.is_watertight)
print("consistent winding:", m.is_winding_consistent)
print("bodies:", m.body_count)
```

Require actual inspection when geometry is fragile: thin webs, slits, tabs, countersinks, internal cavities, magnet pockets, overhangs, interlocking joints and alignment pins.

## Slicer qualification

Use the printer's native slicer or a well-supported equivalent. For a Bambu printer, Bambu Studio is a natural choice.

Check the **actual** machine and bed envelope, nozzle diameter, material and filament profile, build plate, print orientation, bed adhesion, supports/bridging, layer height, wall count, infill density/pattern, first layer, and thin-feature treatment. Inspect the **layer-by-layer toolpath preview** around small details before printing.

Save and label the **native slicer project** (often `.3mf`), including printer/plate/filament/process settings when supported. A geometry-only OpenSCAD `.3mf` file is **not** the same thing as a tested slicer profile.

Do not copy every default setting into documentation. Record what is needed to reproduce the successful print; for example printer, nozzle, material, plate, layer height, walls, infill, supports, orientation and any unusual overrides.

## Test, measure, and revise

Define one or two **specific pass criteria** before each print: fit, clearance, access, retention, deflection, print finish or dimensional envelope.

When uncertainty centers on a feature (hole, clip, friction fit, magnet pocket), consider a **small coupon** rather than reprinting the entire object. Test the least expensive geometry that answers the actual question.

Capture physical evidence as **measured** (calipers, fit tests, observed failure). Separate from tool-confirmed geometry, estimated tolerances or unverified printer/material claims. Don't infer safety or universal fit from one successful print.

Make localized parametric revisions, commit them, and preserve known-good source and exports. A significant tested milestone deserves a GitHub baseline.

## Release and MakerWorld (optional)

- Preserve matched `src/` source, `exports/` STL and slicer profile, and `photos/` of the real print.
- Commit and verify remote branch HEAD; tag tested versions if useful and approved. Never silently overwrite proven releases.
- Use actual product photographs where required, label CAD renders and AI illustrations correctly, and check that labels or background details do not reveal personal information.
- Record actual hardware dimensions and sources, step-by-step assembly, verified print settings and licensing/attribution.
- Don't assume a repository's software source license and a model-sharing platform's license are interchangeable. Only the rightsholder can grant separate licenses.
- Link the published model to the GitHub README and save the final commit.

## Confidence labels

**Measured:** actual caliper or physical fit data.  
**Tool-verified:** documented rendering, mesh bounds, slicer preview, Git commit SHA.  
**Inferred:** estimated tolerance or strength based on engineering reasoning.  
**Unverified:** untested variants, printer/material compatibility inferred from another device.
