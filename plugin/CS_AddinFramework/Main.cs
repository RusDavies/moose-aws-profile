using System;
using System.Windows.Forms;

namespace CS_AddinFramework
{
	public class Main
	{
		private bool m_ShowFullMenus = false;
		public Form1 theForm;

		//Called Before EA starts to check Add-In Exists
		public String EA_Connect(EA.Repository Repository)
		{
			//No special processing required.
			return "a string";
		}

		//Called when user Click Add-Ins Menu item from within EA.
		//Populates the Menu with our desired selections.
		public object EA_GetMenuItems(EA.Repository Repository, string Location, string MenuName) 
		{
			EA.Package aPackage = Repository.GetTreeSelectedPackage();
			switch( MenuName )
			{
				case "":
					return "-&CS AddinFramework";
				case "-&CS AddinFramework":
					string[] ar = { "&Menu1", "&Menu2", "About..." };
					return ar;
			}
			return "";
		}
		
		//Sets the state of the menu depending if there is an active project or not
		bool IsProjectOpen(EA.Repository Repository)
		{
			try
			{
				EA.Collection c = Repository.Models;
				return true;
			}
			catch
			{
				return false;
			}
		}

		//Called once Menu has been opened to see what menu items are active.
		public void EA_GetMenuState(EA.Repository Repository, string Location, string MenuName, string ItemName, ref bool IsEnabled, ref bool IsChecked)
		{
			if( IsProjectOpen(Repository) )
			{
				if( ItemName == "Menu1" )
					IsChecked = m_ShowFullMenus;
				else if( ItemName == "Menu2")
					IsEnabled = m_ShowFullMenus;
			}
			else
				// If no open project, disable all menu options
				IsEnabled = false;
		}

		//Called when user makes a selection in the menu.
		//This is your main exit point to the rest of your Add-in
		public void EA_MenuClick(EA.Repository Repository, string Location, string MenuName, string ItemName)
		{						
			switch( ItemName )
			{
				case "&Menu1":					
					break;					
				case "&Menu2":					
					break;
				case "About...":
					Form1 anAbout = new Form1();
					anAbout.ShowDialog();					
					break;
			}
		}
	}
}
		
		
	

