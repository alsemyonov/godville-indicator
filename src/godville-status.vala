using GLib;
using Soup;
using Xml;
using AppIndicator;

namespace Godville {
  public class Status {
    private string url;
    private string response;
    private StatusIndicator indicator;

    public bool arena_fight;
    public bool town;
    public int bricks_cnt;
    public int distance;
    public int exp_progress;
    public int godpower;
    public int health;
    public int inventory_max_num;
    public int inventory_num;
    public int level;
    public int max_health;
    public int quest_progress;
    public string alignment;
    public string clan;
    public string clan_position;
    public string diary_last;
    public string gender;
    public string godname;
    public string gold_approx;
    public string hero_name;
    public string motto;
    public string quest;
    public string town_name;

    private int timeout_number = 0;
    private bool autorefresh = true;

    public Status(string name, StatusIndicator indicator) {
      godname = name;
      this.indicator = indicator;
      url = "http://godville.net/gods/api/%s.xml".printf (godname);

      Timeout.add (60000, () => {
        timeout_number++;
        message ("Timeout №%i".printf (timeout_number));
        refresh ();
        return autorefresh;
      });
    }

    public void refresh () {
      load ();
      parse ();
      indicator.update_status (this);
    }

    private void load () {
      message ("Getting data from %s\n".printf (url));
      // Create an HTTP session for godville
      var session = new Soup.SessionAsync ();
      var message = new Soup.Message ("GET", url);

      // send an HTTP request
      session.send_message (message);
      response = (string) message.response_body.flatten ().data;
    }

    private void parse () {
      // Parse the document from response
      Xml.Doc* doc = Parser.parse_memory (response, (int) response.length);

      if (doc == null) {
        stderr.printf ("User %s not found", godname);
        return;
      }

      // Get the root node. notice the dereferencing operator -> instead of .
      Xml.Node* root = doc->get_root_element ();
      if (root == null) {
        // Free the document manually before returning
        delete doc;
        stderr.printf ("The url '%s' is incorrect", url);
        return;
      }

      // TODO parse root
      for (Xml.Node* iter = root->children; iter != null; iter = iter->next) {
        // Spaces between tags are also nodes, discard them
        if (iter->type != ElementType.ELEMENT_NODE) {
          continue;
        }

        // Get the node's name
        string node_name = iter->name;
        // Get the node's content with <tags> stripped
        string node_content = iter->get_content ();

        if (node_name == "name") {
          hero_name = (string) node_content;
        } else if (node_name == "godname") {
          godname = (string) node_content;
        } else if (node_name == "gender") {
          gender = (string) node_content;
        } else if (node_name == "gold_approx") {
          gold_approx = (string) node_content;
        } else if (node_name == "motto") {
          motto = (string) node_content;
        } else if (node_name == "clan") {
          clan = (string) node_content;
        } else if (node_name == "clan_position") {
          clan_position = (string) node_content;
        } else if (node_name == "alignment") {
          alignment = (string) node_content;
        } else if (node_name == "quest") {
          quest = (string) node_content;
        } else if (node_name == "diary_last") {
          diary_last = (string) node_content;
        } else if (node_name == "town_name") {
          town_name = (string) node_content;
          if (town_name == "") {
            town = false;
          } else {
            town = true;
          }
        } else if (node_name == "level") {
          level = (int) node_content.to_int ();
        } else if (node_name == "health") {
          health = (int) node_content.to_int ();
        } else if (node_name == "max_health") {
          max_health = (int) node_content.to_int ();
        } else if (node_name == "inventory_num") {
          inventory_num = (int) node_content.to_int ();
        } else if (node_name == "inventory_max_num") {
          inventory_max_num = (int) node_content.to_int ();
        } else if (node_name == "quest_progress") {
          quest_progress = (int) node_content.to_int ();
        } else if (node_name == "exp_progress") {
          exp_progress = (int) node_content.to_int ();
        } else if (node_name == "godpower") {
          godpower = (int) node_content.to_int ();
        } else if (node_name == "bricks_cnt") {
          bricks_cnt = (int) node_content.to_int ();
        } else if (node_name == "distance") {
          distance = (int) node_content.to_int ();
        } else if (node_name == "arena_fight") {
          if (node_content == "true") {
            arena_fight = true;
          } else {
            arena_fight = false;
          }
        } else {
          debug ("%s: %s\n".printf (node_name, node_content));
        }

        //TODO parse node’s properties
      }

      delete doc;
      return;
    }
  }
}
