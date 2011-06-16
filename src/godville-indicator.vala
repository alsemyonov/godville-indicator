using Gtk;
using AppIndicator;

namespace Godville {
  public class StatusIndicator {
    private Indicator indicator;
    private Menu menu;

    private MenuItem godname_item;
    private MenuItem heroname_item;
    private MenuItem diary_item;

    private string godname;

    public StatusIndicator (string name) {
      godname = name;

      indicator = new Indicator (name, "indicator-messages", IndicatorCategory.APPLICATION_STATUS);
      indicator.set_status (IndicatorStatus.ACTIVE);
      indicator.set_attention_icon ("indicator-messages-new");

      menu = new Menu ();

      godname_item = new MenuItem.with_label("Годвилль");
      godname_item.activate.connect (() => {
        try {
          Process.spawn_command_line_async ("xdg-open http://godville.net/gods/%s".printf (name));
        } catch (SpawnError e) {
          error ("Cannot open god’s page: %s".printf (e.message));
        }
      });
      godname_item.show ();
      menu.append (godname_item);

      heroname_item = new MenuItem.with_label("Данные о герое загружаются…");
      heroname_item.activate.connect (() => {
        try {
          Process.spawn_command_line_async ("xdg-open http://godville.net/superhero");
        } catch (SpawnError e) {
          error ("Cannot open hero’s page: %s".printf (e.message));
        }
      });
      heroname_item.show ();
      menu.append (heroname_item);

      diary_item = new MenuItem();
      diary_item.sensitive = false;
      menu.append (diary_item);

      var separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      var item = new MenuItem.with_label ("Выход");
      item.activate.connect (Gtk.main_quit);
      item.show ();
      menu.append (item);

      indicator.set_menu (menu);
    }

    public void attention() {
      indicator.set_status (IndicatorStatus.ATTENTION);
    }

    public void update_status(Status status) {
      godname_item.set_label (status.godname);
      heroname_item.set_label (status.hero_name);

      if (status.diary_last == "") {
        diary_item.hide();
      } else {
        diary_item.set_label (status.diary_last);
        diary_item.show();
      }

      indicator.set_label ("%i / %i".printf (status.health, status.max_health), "1000 / 1000");
    }
  }
}
