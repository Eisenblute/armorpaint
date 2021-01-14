package arm.ui;

import zui.Zui;
import zui.Id;
import arm.util.MeshUtil;

class TabMeshes {

	@:access(zui.Zui)
	public static function draw() {
		var ui = UISidebar.inst.ui;
		if (ui.tab(UISidebar.inst.htab2, tr("Meshes"))) {

			ui.beginSticky();
			ui.row([1 / 4, 1 / 4]);

			if (ui.button(tr("Import"))) {
				UIMenu.draw(function(ui: Zui) {
					ui.text(tr("Import"), Right, ui.t.HIGHLIGHT_COL);
					if (ui.button(tr("Replace Existing"), Left)) {
						Project.importMesh(true);
					}
					if (ui.button(tr("Append"), Left)) {
						Project.importMesh(false);
					}
				}, 3);
			}
			if (ui.isHovered) ui.tooltip(tr("Import mesh file") + ' (${Config.keymap.file_import_assets})');

			if (ui.button(tr("Tools..."))) {
				UIMenu.draw(function(ui: Zui) {
					ui.text(tr("Tools"), Right, ui.t.HIGHLIGHT_COL);
					if (ui.button(tr("Flip Normals"), Left)) {
						MeshUtil.flipNormals();
						Context.ddirty = 2;
					}
					if (ui.button(tr("Calculate Normals"), Left)) {
						MeshUtil.calcNormals();
						Context.ddirty = 2;
					}
					if (ui.button(tr("Rotate X"), Left)) {
						MeshUtil.swapAxis(1, 2);
						Context.ddirty = 2;
					}
					if (ui.button(tr("Rotate Y"), Left)) {
						MeshUtil.swapAxis(2, 0);
						Context.ddirty = 2;
					}
					if (ui.button(tr("Rotate Z"), Left)) {
						MeshUtil.swapAxis(0, 1);
						Context.ddirty = 2;
					}
				}, 6);
			}

			ui.endSticky();

			for (o in Project.paintObjects) {
				var h = Id.handle();
				h.selected = o.visible;
				o.visible = ui.check(h, o.name);
				if (h.changed) Context.ddirty = 2;
			}
		}
	}
}
