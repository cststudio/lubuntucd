#include <stdio.h>

#include <locale.h>
#include <libintl.h>

#define _(str) gettext(str)
#define LOCALEDIR "/usr/share/locale"
#define PACKAGE "textdemo"

int main(void)
{
    int i = 0;
    setlocale(LC_ALL, "");
    bindtextdomain(PACKAGE, LOCALEDIR);
    textdomain(PACKAGE);
    
    printf(_("This is GetText test.\n"));
    printf(_("Hello world.\n"));
    printf(_("My name is Late Lee.\n"));
    for (i = 0; i < 3; i++)
    {
        printf(_("output: %d\n"), i);
    }

    printf(_("end of test.\n"));
    return 0;
}
