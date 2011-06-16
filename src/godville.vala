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
using AppIndicator;

namespace Godville {
    static int main (string[] args) {
      Gtk.init (ref args);

      string name = "Мартынчик";

      var settings = new GLib.Settings ("net.godville.indicator");
      debug (settings.get_string("name"));
      var indicator = new StatusIndicator (name);
      var status = new Status (name, indicator);

      Gtk.main ();
      return 0;
    }
}
