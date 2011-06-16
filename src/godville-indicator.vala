using Gtk;
using AppIndicator;
using Notify;

namespace Godville {
  public class StatusIndicator {
    private Indicator indicator;
    private Menu menu;

    private MenuItem god_item;
    private MenuItem hero_item;
    private MenuItem statistics_item;
    private MenuItem diary_item;

    private string godname;

    public StatusIndicator (string name) {
      godname = name;

      indicator = new Indicator (name, "indicator-messages", IndicatorCategory.APPLICATION_STATUS);
      indicator.set_status (IndicatorStatus.ACTIVE);
      indicator.set_attention_icon ("indicator-messages-new");

      menu = new Menu ();

      god_item = new MenuItem.with_label("Годвилль");
      god_item.activate.connect (() => {
        try {
          Process.spawn_command_line_async ("xdg-open http://godville.net/gods/%s".printf (name));
        } catch (SpawnError e) {
          error ("Cannot open god’s page: %s".printf (e.message));
        }
      });
      god_item.show ();
      menu.append (god_item);

      hero_item = new MenuItem.with_label("Данные о герое загружаются…");
      hero_item.activate.connect (() => {
        try {
          Process.spawn_command_line_async ("xdg-open http://godville.net/superhero");
        } catch (SpawnError e) {
          error ("Cannot open hero’s page: %s".printf (e.message));
        }
      });
      hero_item.show ();
      menu.append (hero_item);

      var separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      diary_item = new MenuItem();
      /*diary_item.sensitive = false;*/
      menu.append (diary_item);

      separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      statistics_item = new MenuItem();
      /*statistics_item.sensitive = false;*/
      menu.append (statistics_item);

      separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      var item = new MenuItem.with_label ("Обновить");
      item.activate.connect (() => {
        status.refresh();
      });
      item.show ();
      menu.append (item);

      separator = new SeparatorMenuItem ();
      separator.show ();
      menu.append (separator);

      item = new MenuItem.with_label ("Выход");
      item.activate.connect (Gtk.main_quit);
      item.show ();
      menu.append (item);

      indicator.set_menu (menu);
    }

    public void attention() {
      indicator.set_status (IndicatorStatus.ATTENTION);
    }

    public void unattention() {
      indicator.set_status (IndicatorStatus.ACTIVE);
    }

    public void update_status(Status status) {
      god_item.set_label (
        "%s\nПрана: %i%%".printf (status.godname, status.godpower)
      );

      string gender;
      if (status.gender == "male") {
        gender = "Герой";
      } else {
        gender = "Героиня";
      }

      if (status.motto == "") {
        hero_item.set_label (
          "%s — %s\nУровень %i и ещё %i%%\nХарактер: %s".printf (gender, status.hero_name, status.level, status.exp_progress, status.alignment)
        );
      } else {
        hero_item.set_label (
          "%s — %s:\n«%s»\nУровень %i и ещё %i%%\nХарактер: %s".printf (gender, status.hero_name, status.motto, status.level, status.exp_progress, status.alignment)
        );
      }

      statistics_item.set_label ("Здоровье: %i/%i\nИнвентарь: %i/%i\nЗолота: %s\nКирпичей для храма: %i\nСтолбов от столицы: %i шт.\nЗадание: %s (%i%%)".printf (
        status.health, status.max_health,
        status.inventory_num, status.inventory_max_num,
        status.gold_approx,
        status.bricks_cnt,
        status.distance,
        status.quest,
        status.quest_progress));
      statistics_item.show();

      if (status.diary_last == "") {
        diary_item.hide();
      } else {
        diary_item.set_label (status.diary_last);
        diary_item.show();
      }

      if (status.arena_fight) {
        attention();
      } else {
        unattention();
      }

      indicator.set_label ("%i".printf (status.level), "100");
      var notification = new Notification (
        "%s (%i/%i)".printf (status.hero_name, status.health, status.max_health),
        status.diary_last,
        null,
        null
      );
      try {
        notification.show();
      } catch (Error e) {
        message ("Notification. %s: %s".printf (notification.summary, notification.body));
      }
    }
  }
}
