/* main.vala
 *
 * Copyright (C) 2010  Alexander Semyonov
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author:
 *  Alexander Semyonov <al@semyonov.us>
 */

using GLib;
using Gtk;
using Notify;

namespace Godville {
  static Status status;
  static int main (string[] args) {
    Gtk.init (ref args);

    string app_name = "Годвилль";

    Notify.init (app_name);
    var settings = new GLib.Settings ("net.godville.indicator");

    string name = args[1];
    if (name == null) {
      name = settings.get_string ("name");
    }
    if (name == "") {
      name = "Мартынчик";
    }
    settings.set_string ("name", name);

    var indicator = new StatusIndicator (name);
    status = new Status (name, indicator);
    status.refresh ();

    Gtk.main ();
    return 0;
  }
}
