 Description:    VK DBF is TDataSet component for work with DBF tables,
                 DBT and FPT LOB storage and NTX indexes from CLIPPER.
                 This is much more then only DBFNTX driver for Delphi.
                 It supports many extended types (~60) such as Byte,
                 Word, Indeger, Int64, Real4, Real6, Real8, Binary LOB
                 any size and so on...
                 There is a Crypt DBF feature.

 Versions:

		    5) Create Delphi 2009 package.
		    4) VerifyIndex was added
		    3) Fix bug: records not deleted after [1.0.8.10 beta 1)]
                       modification.
		    2) Fix bug: access voilation in FileLock procedure,
                       when table is empty.
                    1) Fix bug in AddFields and DeleteFields procedures.
                       Not init record buffer with blanks.
                 1.0.8.10 beta
                    2) Now VKDBF can read 'N' fields with ',' decimal separator.
		                1) fix bug. When invoke RLock or FLock not refresh record
		                   buffer.
                 1.0.8.0 beta
                   22) fix bug in TVKSmartDBF.SaveToDBT procedure when save lob
                       in SaveOnTheSamePlace mode.
                   21) add ReCrypt method.
                   20) add cmCustomer mode in Crypt object.
                   19) fix bug in TVKDBFExprParser.SuiteFieldList: the suitable
                       index define not correct.
                   18) add methods
                         SetRange(FieldList; FieldValuesLow; FieldValuesHigh);
                   17) add DeleteFields method.
                   16) add AddFields method.
                   15) Fix bug: DBEval not work with crypt table.
                   14) Add IsRLock method.
                   13) Fix bug: Incorect handle LOB field with types *_NB.
                   12) Fix bug: incorect handle 'I' type fields.
                   11) Make TGostCrypt.InitKey1 and new type of Crypt method - Gost1
                   10) develop DESCEND function with DATE type.
                    9) Realize PADL, PADR, PADC function in parser.
                    8) Make package for Delphi 2005.
                    7) Advance TVKTrieTreeSorter class.
                    6) Fix bug (AV and wrong found key) in
                        function TVKSmartDBF.FindKey(
                          const KeyValues: array of const): Boolean;
                        function TVKSmartDBF.FindNearest(
                          const KeyValues: array of const): boolean;
                    5) DESCEND() function was realized in TVKDBFExprParser class.
                    4) Fix bug: Don't work TVKSmartDBF.Pack for encrypted files.
		    3) Fix bug: FLock, RLock(nRec), Unlock, RUnlock...
                    2) Fix bug: TVKNTXOrder.CreateOrder work incorrect when Crypt.Active = True.
                    1) Fix bug: Master->Detail with TrimCType property not work.
                 1.0.7.0 beta
                    1) Fix bug: TVKNTXIndex.FindKey. When FindKey find key in
                       several the same key values where first value is in
                       deleted record and SetDeleted property is
                       True then FindKey didn't find next key in normal record.
                    2) Add property TrimInLocate: boolean; for control
                       trailing spaces in key for Locate() method.
                       At the instance of guys from Falcon-Soft
                       (http://www.falconsoft.hu).
                    3) Add functions ANSIUPPER() and ANSILOWER() in VKDBFParser.
                       Change UPPER() and LOWER() functions to call Delphi
                       UpperCase() and LowerCase() functions (instead of
                       AnsiUpperCase() and AnsiLowerCase(), now it use in
                       ANSIUPPER() and ANSILOWER()).
                    4) Fix bug: Not save
                          property Collation
                          property LimitPages
                       in DFM file.
                       property NTXRange save in DFM not correct.
                    5) Fix bug: When TVKDBFOrder object has destroied then
                       according TIndex object must be destroy. Otherwise
                       any monipulation with it bring to "Access vialation".
                    6) Fix bug: In TVKNTXIndex.CompareKeys procedure replace
                        CharToOem(pChar(S1), T1);
                        CharToOem(pChar(S2), T2);
                       to
                        TVKDBFNTX(FIndexes.Owner).Translate(S1,
                                                    pChar(@T1[0]), True);
                        TVKDBFNTX(FIndexes.Owner).Translate(S2,
                                                    pChar(@T2[0]), True);
                       It makes right order with collation when OEM = False;
                    7) Make TVKNTXIndex.CreateIndexUsingQuickSort
                       procedure;
                    8) Add pre-sort buffer in TVKNTXIndex.CreateIndex method
                       and add PreSorterBlockSize: LongWord parameter to this
                       procedure;
                    9) Optimize FUseCount variable in TVKNTXBuffer class;
                    10) Fix bug in TVKRAMQuickSorter.Sort procedure: "Access
                        violation"
                    11) Fix bug in TVKNTXIndex.FindKeyFields for partual string
                        keys
                    12) Make TVKNTXIndex.CreateIndexUsingTreeSort
                        and TVKNTXIndex.CreateIndexUsingRBTreeSort
                        procedures;
                    13) Remove property TIndex.CustomCollatingTable, this type
                        not support in Borland C++Builder :-(
                    14) Fix some memory licks;
                    15) Made TVKNTXIndex.CreateIndexUsingSorter procedure to
                        create index file using different method of inner and
                        outer sorting.
                        Such as TVKQuickSorter, TVKBinaryTreeSorter,
                        TVKRedBlackTreeSorter, TVKAVLTreeSorter (any
                        class extends TVKSorterAbstract).
                    16) Made TVKNTXIndex.CreateIndexUsingAVLTreeSort
                    17) Made hash table for Binary Tree Sorters, -
                        TVKBinaryTreeSorter, TVKRedBlackTreeSorter,
                        TVKAVLTreeSorter (any class extends
                        TVKBinaryTreeSorter)
                    18) Made new properties to manage hash table in binary tree
                        sorters:
                        property HashTypeForTreeSorters: TVKHashTypeForTreeSorters;
                        property MaxBitsInHashCode: TVKMaxBitsInHashCode;
                    19) Fix bug. When procedure TVKNTXIndex.CreateIndex work in
                        Exclusive mode not properly set FUpdated variable and
                        work with index become unavailable.
                    20) I've made new procedure to create index -
                        TVKNTXIndex.CreateIndexUsingMergeBinaryTreeAndBTree.
                        I thought it will be cool, but it's turned out sediment.
                    21) Has made TVKNTXIndex.CreateIndexUsingBTreeHeapSort, but
                        it's also sediment.
                    22) Has made TVKNTXIndex.CreateIndexUsingFindMinsAndJoinItToBTree, but
                        it is sediment too.
                    23) Has made TVKNTXIndex.CreateIndexUsingAbsorption.
                        Do you guess? Yes! It's sediment.
                    24) Has made TVKNTXIndex.CreateIndexUsingTrieTreeSort. It's
                        inner sort method. It's work good, but needs very mach
                        memory. In the future I'll make it with
                        flexible TVKTrieNode chain. And I think it will be much
                        better.
                    25) Has made TVKNTXIndex.CreateIndexUsingAbsorptionSort. It's
                        outer sort method. It's not vary good. I'll work further...
                    26) Remove TVKNTXIndex.CreateIndex methods:
                          TVKNTXIndex.CreateIndexUsingMergeBinaryTreeAndBTree
                          TVKNTXIndex.CreateIndexUsingBTreeHeapSort
                          TVKNTXIndex.CreateIndexUsingFindMinsAndJoinItToBTree
                          TVKNTXIndex.CreateIndexUsingAbsorption
		    27) Add TVKNTXIndex.LimitPages.PagesPerBuffer; property
		    28) Add AutoInc field in Locate method.
                    29) Change master->detail mechanism. Now it's work by
                        PartualKeyValue.
                    30) Fix bug in master->detail mechanism.
		    31) Fix bugs in GetFieldData method.
		    32) Add OuterSorterProperties property to TIndex object
		    	for manage Outer Sorter Merge algorithm.
		    33) Add
	    			procedure TIndex.CreateIndexUsing8PathMergeSort;
	    			procedure TIndex.CreateIndexUsing4PathMergeSort;
	    			procedure TIndex.CreateIndexUsingMergeSort;
			procedures for Create indexes using outer merge sort
			algorithm.
                    34) Add property TrimCType for manage retrive values from 'C' type datatype.
                 1.0.6 beta 02.03.2004
                    1) Fix error in Locate by index. If Index containt key like
                       '50' and you try Locate('Id',VarArrayOf(['5']),[]) then
                       this locate find key '50';
                    2) Fix bug in
                       function TVKNTXRange.InRange(S: String): boolean;
                       Now it correct determinate is S in NTXRange or not.
                       It need for set RecNo while Range is active, for
		                   example...;
                    3) Fix bug: incorrect create index when key size more then
		    	             194 chars;
		                4) For types ( dbftString, dbftString_N,
		    	             dbftFixedChar, dbftWideString ) set length more than
			                 255 bytes;
                    5) Fix bug: incorrect create index for decimal keys for D6
		    	             and D7;
                    6) Add parameter TmpInCurrentPath: boolean in
                       TVKSmartDBF.Pack and TIndexes.CreateCompactIndex methods
                       for manage location of temporary files created in these
                       methods;
                    7) Fix bug: TVKNTXIndex.FindKey function not work correctly
                       when seek first key in the range of the same keys;
                    8) Limit loaded NTX pages in mamory:
                        property TIndex.LimitPages: TVKLimitIndexPages;
                    9) Add functions to Expression Parser:
                          - VAL();
                          - STUFF();
                          - STRTRAN();
                    10) Add new parameter var ExitCode: Integer into OnDBEval and
                        OnSubIndex events for controling exit from evalution loop.
                        If you set ExitCode := 1 the evalution loop will be
			                  stop;
                    11) DBASE 4 - 7 support:
                          - support DBase types 'I', '+', 'O', '@',
			  	                  'B', 'F', 'G';
			                    - support DBase 7 LOB storage (DBT file);
			                    - support locking schema for DBase 3 - 7;
                    12) FoxPro and Visual FoxPro support:
                          - support Visual FoxPro types 'C binary', 'M
			  	                  binary', 'Y', 'T', 'P', 'B', 'I', 'G';
			                    - support  FoxPro LOB storage (FPT file);
			                    - support locking schema for Visual FoxPro;
			                    - support NULLs for Visual FoxPro;
                    13) support Auto-increment fields for DBase and Visual FoxPro;
                    14) New
                        property LobVersion: xBaseVersion;
                        property LobBlockSize: Integer;
                        property LockProtocol: LockProtocolType;
                        property LobLockProtocol: LockProtocolType;
                        property FoxTableFlag: TTableFlag;
                        was added;
                    15) Collation engine was added in each order and index:
                        property TIndex.Collation: TVKCollation;
                    16) 16 collation tables + one custom collation table;
		    17) More...;
                 1.0.5 beta 18.10.2002
                    1) New property StorageType
                    2) property DBFFieldDefs now fill fields definition on open DataSet
                    3) New data tapes:
                          dbftDBFDataSet,         // DataSet
                          dbftDBFDataSet_NB,      // DataSet with absolute pointer
                                                  // (dbftU4_NB) to a lob
                                                  // file and not align 512 byte
                                                  // pages into the Lob

                    4) New component TVKNestedDBF related with dbftDBFDataSet and
                       dbftDBFDataSet_NB.
                    5) Fix bug when Field.IsNull for 'C' data type always return True.
                       (Thanks Alexander Manuzin)
                    6) Fix bug in TVKSmartDBF.NextBuffer. When read 1A end byte, it
                       replace first byte in FBuffer (Delete byte in first record in
                       FBuffer).
                    7) Fix bug: When Edit record and it filtered by Filter or
                       SetDeleted the record is not hidden in DB-Aware controls.
                    8) Add SoftSeek parameter in TVKNTXIndex.FindKey procedure.
                    9) TVKNTXIndex.Seek, TVKNTXIndex.SeekFirst,
                       TVKNTXIndex.SeekFirstRecord, TVKNTXIndex.SeekFields made
                       throw TVKNTXIndex.FindKey procedure subject to SetDeleted,
                       Filter and Range.
                    10) Fix bug: IsNull in culculated and lookup field not work.
                    11) Add Validation handler to the Field and ReadOnly check.
                    12) On SetDeleted and Filtered call Refresh method
                        (it was First method).
                    13) Add properties TVKDBFNTX.Orders[Num]: TVKNTXIndex and
                        TVKDBFNTX.OrdersByName[Name]: TVKNTXIndex
                    14) Make Source for D5 and D6. (Use $IFDEF VER130, VER140)
                    15) Delete property TAccessMode.ShareDenyRead and
                        TAccessMode.ShareCompat
                    16) Fix bug: Incorrect work with OEM Unique index.
                    17) Fix bug: If LookUp result Integer or Float - error.
                    18) Fix bug: Lookup field by calculated field - error.
                    19) Now Filtering record accepted into the DataSet use
                        Filter string AND OnFilterRecord event together.
                    20) Fix bug: When set range by index for LowKey and HiKey
                        are out of keys in index the DataSet show last record by
                        index.
                    21) Fix bug: Modify DataSet incorrect when unique index or
                        FOR index used.
                    22) Make over Range.
                    23) Add parameter Rec in TVKNTXIndex.FindKey method.
                    24) Fix bug: 'Variant array index out of bounds' with
                        partual key search in TVKSmartDBF.FindKey for multiple
                        key.
                    25) Property IndexDefs...
                    26) Property IndexBags... with set of orders and StorageType.
                    27) Add functions in Expression Parser:
                          - IF()
                          - IIF()
                          - RIGHT()
                          - LEFT()
                          - SPACE()
                          - STRZERO()
                          - ALLTRIM()
                    28) Add TVKDBFFieldDef.Tag property. Use it instead of
                        TField.Tag because TField.Tag occupied with TVKDBFFieldDef
                        object reference.

                        ATTANTION:
                          Use TVKDBFFieldDef(TField.Tag).Tag
                            instead of
                          TField.Tag

                    29) Add error 'TVKSmartDBF.InternalOpen: BufferSize too small!'
                    30) Message 'Table %s create successfully!' not appear in
                        Loading state.
                 1.0.4 beta 23.05.2002
                    1) Add Method TranslateBuff and rewrite methods
                       CreateBlobStream and SaveToDBT with TranslateBuff
                       to prevent 'Access violation' in read and write CLOB.
                    2) When set RecNo check Filter, SetDeleted and Range validation.
                    3) Fix bud in TVKNTXRange.InRange(S: String) method
                    4) Add event OnCreateIndex
                    5) Add public var FullLengthCharFieldCopy to TVKSmartDBF for
                       manage SetFieldData for 'C' type fields
                    6) Fix buf with allocate memory for FLocateBuffer (AV when
                       Locate, Lookup, ReindexAll, DBEval or Pack if BufferSize <> 4096)
                    7) Complex actions to make index compatibility with CLIPPER:
                            - Full rewrite TVKNTXIndex.DeleteKey procedure, now it
                              normalize index like a CLIPPER.
                            - Make TVKNTXIndex.DeleteKeyStyle property to switch
                              Delete Key style between CLIPPER normalize index and
                              all athers (Apollo, Halcyon...).
                            - Add TVKNTXCompactIndex.NormalizeRest method to make
                              normalize index in TVKNTXIndex.CreateCompactIndex and
                              TVKNTXIndex.SubNtx procedures.

                        ATTENTION: Rebuild all indexes after apply this version !

                    8) Add methods:
                              TVKNTXIndex.FindKey
                              TVKNTXIndex.FindKeyFields with overloaded some parameters
                       It is the same SeekFirst..., but subject to SetDeleted, Filter
                       and Range.
                       Partual key sapport Ok!
                    9) Rewrite Lokate and Lookup on TVKNTXIndex.FindKeyFields.
                    10) Add methods:

                              TVKSmartDBF.SetKey;
                              TVKSmartDBF.EditKey;
                              TVKSmartDBF.GotoKey;
                              TVKSmartDBF.GotoNearest;
                              TVKSmartDBF.DropEditKey;
                              TVKSmartDBF.FindKey;
                              TVKSmartDBF.FindNearest;

                        All this methods work throw TVKNTXIndex.FindKeyFields.
                    11) Add TVKSmartDBF.IndexName property.
                    12) Make type 'C' is not be NULL, if field empty Field.AsString
                        return string of spases lethgt of field length.
                 1.0.3 beta 25.03.2002
                    1) In Mamory manager add raise error 'TVKDBFOneAlloc: Can not
                       allocate 0 bytes memory!'
                    2) Add methods CompareBookmarks, BookmarkValid
                    3) CretateNow -> CreateNow
                    4) Deleted constant LOCATE_BUFFER_SIZE
                    5) Check empty KeyValues in LocateRecord->LocatePass
                    6) Fixed bug in indexing Int64 fields
                    7) TVKNTXIndex.CreateCompactIndex method was added
                    8) Add Partial Key for index Locate and SeekFirst methods
                       in TVKNTXIndex class
                    9) Add 1A byte at end of DBF table in InternalClose method
                    10) Add DBEval method and OnDBEval event
                 1.0.2 beta 18.02.2002
                    1) Pack method was added;
                    2) LookupOptions property was added;
                    3) Explicitly type convention in SeekFields, Lookup, Locate
                       was added;
                    4) Recall and Delete record methodths was added;
                    5) Explicit full scan added in LocateRecord method;
                    6) ReindexAll method was added;
                    7) Fix bug with dbftBlob and dbftGraphic types;
                    8) Fix bug 'List index out of bounds' for index expression
                       with Numeric literal contain decimal separator. Ambiguously
                       determined decimal separator and literal separator ','.
                 1.0.1 beta 28.01.2002
                    1) Fix bug in Exclusive index support;
                    2) Fix bug in Add Fields in Design time;
                    3) Fix bug with Long Number fields (like ["F1", "N", 10, 0]);
                    4) WideString support was added;
                    5) Truncate (ZAP) method was added;
                    6) More...;
 		 1.0.0 beta 28.01.2002

 WISH:

          	-   Realize IDX and CDX indexes.
          	-   Realize NDX and MDX indexes.
          	-   New locate type by ordered DBF.
          	-   Range by index don't work with descended index
          	-   Realize Cashed updates.
