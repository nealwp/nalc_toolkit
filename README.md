# Nalc Toolkit

## What This Is

A command line application for servers running 

- 65 different commands
- most commands have a corresponding SQL procedure
- All commands have input validation
- Each command has a docstring

## Usage

```bash
tk <command>
```

`cmd-edit`
edits an existing Toolkit file

`cmd-list`
print list of available commands

`db-columns`
show columns for table name/partial table name/column name

`db-getsql`
show sql for a trigger or stored procedure

`db-incrdump`
takes an incremental backup of the database

`db-purgeintfc`
cleans up the interface records

`db-storedprocs`
show store procedures for name/partial name

`db-tables`
show matching tables for table name/partial table name

`db-transledg`
queries the transledger for a niin/ddsn/mcn 

`ddsn`
runs a ddsn query in p2db

`ddsn-activate`
moves a ddsn from dr14 to dr09

`ddsn-buno`
updates the buno for a ddsn

`ddsn-compl`
update a ddsn to COMPL and set pod_qty 

`ddsn-create-suffix`
create a dr09 suffix based on existing ddsn

`ddsn-createiou`
creates a dr06 record for a ddsn and updates the iou_qty 

`ddsn-fixmcn`
fixes cur/rep mcn on dr09 to resolve Critical Error when clearing CRA

`ddsn-ioukill`
deletes a dr06 record for a ddsn and updates the so_iou_qty 

`ddsn-kill`
deletes a requisition from dr09. 

`ddsn-lscdttm`
updates the lsc_dttm for a ddsn

`ddsn-org`
updates the org_cd for a ddsn

`ddsn-scan`
scans all of p2db for ddsn

`ddsn-status`
update the status code, ri from, and status date on an active requistion 

`ddsn-uncanx`
update a cancelled ddsn to REFER, cnx_qty 0 

`execsql`
executes a .sql file in isql (old)

`execsqld`
executes an sql string in isql (updated)

`goto`
quick ssh to a given site

`help`
prints out commands and descriptions for Toolkit

`hist`
displays Toolkit command history

`isql`
launches isql in p2db

`jdate`
converts a Julian Date to a calendar date and vice versa

`ldap-rmuser`
fully removes a user from NTCSS and all assigned apps via LDAP

`maf`
runs a maf query in p2db

`maf-activate`
moves a maf from history to active

`maf-bunofix`
removes the "-" from buno's on a maf that's awaiting induction

`maf-createdifm`
creates a ds03 DIFM record from an existing MAF

`maf-deactivate`
moves a maf from active to history

`maf-dm09swap`
swaps the remove/install block for a maf

`maf-dm21swap`
swaps the remove/install block for a maf in history

`maf-epartno`
changes the removed part number for a maf

`maf-eserno`
changes the removed serno for a maf

`maf-fixinit`
sets the maf init_dttm to the earliest maint_act_dttm

`maf-gserno`
changes the installed serno for a maf

`maf-kickback`
clears MAF signatures back to worker

`maf-kill`
deletes an MCN from all MAF tables

`maf-scan`
scans all of p2db for MCN

`niin`
runs a niin/inventory/fgc/cagepartno query in p2db

`niin-addloc`
creates a location record on the ds07 

`niin-dbag75`
re-calculates ds02_invdata for a NIIN

`niin-difm`
runs a niin/inventory/fgc/cagepartno query in p2db

`puk`
runs a puk query in p2db

`puk-add`
creates a puk record on ds03

`puk-update`
updates the itm_qty for a puk record on ds03

`syb_utils`
what this do?

`sys-cm`
checks if the CM flag is on

`sys-hcn`
checks if the hard copy notice is running

`sys-intfc`
checks if the interface is running

`sys-ntdomain`
changes the NT Domain and restarts ntcss to kick all users

`sys-oomadb`
checks the OOMA_db version in p2db 

`sys-varlog`
what this do??

`test`
dev test file 

`tkt`
displays ticket for the last command run

`util-batch`
. /h/USERS/$USER/toolkit/etc/tk.config

`util-config`
manage ToolKit configuration settings

`util-update`
checks for updates and grabs them

`util-xfertemp`
move a file from /tmp/ to pwd and chmod/chown it

