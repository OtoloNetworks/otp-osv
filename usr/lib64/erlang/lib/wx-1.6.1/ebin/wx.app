%% This is an -*- erlang -*- file.
%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2010. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%

{application, wx,
 [{description, "Yet another graphics system"},
  {vsn, "1.6.1"},
  {modules,
   [
    %% Generated modules
  wxGLCanvas, wxAcceleratorEntry, wxStaticBoxSizer, wxUpdateUIEvent, wxIcon, wxColourPickerEvent, wxBitmapButton, wxImage, wxGraphicsContext, wxPreviewFrame, wxComboBox, wxFontPickerCtrl, wxCheckListBox, wxEvtHandler, wxFileDialog, wxFlexGridSizer, wxPrintDialogData, wxColourData, wxMouseCaptureChangedEvent, wxAuiDockArt, wxDCOverlay, wxClipboardTextEvent, wxChoicebook, wxSystemOptions, wxGridCellFloatRenderer, wxWindowDC, wxColourDialog, wxStatusBar, wxInitDialogEvent, wxEraseEvent, wxTaskBarIconEvent, wxPrintout, wxSysColourChangedEvent, wxListCtrl, wxLocale, wxGraphicsMatrix, wxBitmap, wxCalendarCtrl, wxSizerItem, wxFrame, wxNavigationKeyEvent, wxGraphicsRenderer, wxGridCellBoolRenderer, wxMouseCaptureLostEvent, wxTextEntryDialog, wxIdleEvent, wxStyledTextCtrl, wxListItem, wxSpinCtrl, wxControlWithItems, wxMDIChildFrame, wxStdDialogButtonSizer, wxPrintData, wxDirPickerCtrl, wxKeyEvent, wxEvent, wxIconBundle, wxFontDialog, wxRadioBox, wxCalendarDateAttr, wxGridCellEditor, wxGridCellNumberRenderer, wxSizeEvent, wxLogNull, wxSashLayoutWindow, wxGraphicsObject, wxGridEvent, wx_misc, wxGridCellStringRenderer, wxCommandEvent, wxPreviewCanvas, wxTextAttr, wxScrollWinEvent, wxGraphicsBrush, wxWindowDestroyEvent, wxSetCursorEvent, wxGridCellChoiceEditor, wxChoice, wxControl, wxToggleButton, wxTopLevelWindow, wxGraphicsFont, wxStaticText, wxIconizeEvent, wxJoystickEvent, wxPrinter, wxStaticBitmap, wxGridBagSizer, wxGridSizer, wxScrollEvent, wxWindowCreateEvent, wxGridCellFloatEditor, wxStyledTextEvent, wxPrintDialog, wxStaticBox, wxBufferedDC, wxTextCtrl, wxMaximizeEvent, wxDateEvent, wxCalendarEvent, wxGauge, wxListView, wxSizerFlags, wxGridCellTextEditor, wxShowEvent, wxPrintPreview, wxFindReplaceDialog, wxPageSetupDialogData, wxTextDataObject, wxGraphicsPath, wxMiniFrame, wxListEvent, wxCursor, wxDialog, wxBrush, wxPaintDC, wxScreenDC, wxPopupWindow, wxColourPickerCtrl, wxFilePickerCtrl, wxPostScriptDC, wxGrid, wxAuiSimpleTabArt, wxSashEvent, wxScrolledWindow, wxMask, wxFontData, wxSplitterEvent, wxScrollBar, wxMenuEvent, wxCheckBox, wxQueryNewPaletteEvent, wxListItemAttr, wxMirrorDC, wxAuiManager, wxBoxSizer, wxClipboard, wxMouseEvent, wxDirDialog, wxMenu, wxMDIClientWindow, wxAuiPaneInfo, wxPaintEvent, wxSplitterWindow, wxProgressDialog, wxGridCellNumberEditor, wxListBox, wxActivateEvent, wxNotebookEvent, wxFileDirPickerEvent, wxMenuItem, wxChildFocusEvent, wxMessageDialog, wxButton, wxMenuBar, wxDisplayChangedEvent, wxToolBar, wxGraphicsPen, wxPaletteChangedEvent, wxArtProvider, wxHtmlEasyPrinting, wxFindReplaceData, wxMoveEvent, wxAuiManagerEvent, wxBufferedPaintDC, wxContextMenuEvent, wxLayoutAlgorithm, wxAuiNotebook, wxGridCellBoolEditor, wxMultiChoiceDialog, wxOverlay, wxTaskBarIcon, wxHtmlWindow, wxPageSetupDialog, wxPanel, wxGridCellRenderer, wxSashWindow, wxBitmapDataObject, wxFocusEvent, wxGridCellAttr, wxXmlResource, wxListbook, wxImageList, wxNotifyEvent, wxToolTip, wxPalette, wxSlider, wxSizer, wxSingleChoiceDialog, wxGBSizerItem, wxPen, wxAuiNotebookEvent, wxNotebook, wxDataObject, wxSplashScreen, wxMemoryDC, wxToolbook, wxPopupTransientWindow, wxFileDataObject, wxRadioButton, wxPickerBase, wxCloseEvent, wxDC, wxCaret, wxPasswordEntryDialog, wxAcceleratorTable, wxMDIParentFrame, wxPreviewControlBar, wxHelpEvent, wxStaticLine, wxGenericDirCtrl, wxTreeCtrl, wxFont, wxDatePickerCtrl, wxSystemSettings, wxWindow, wxHtmlLinkEvent, wxTreeEvent, wxSpinEvent, wxFontPickerEvent, wxAuiTabArt, wxRegion, wxClientDC, wxSpinButton, wxTreebook, glu, gl,
    %% Handcrafted modules
    wx,
    wx_object,
    wxe_master,
    wxe_server,
    wxe_util
   ]},
  {registered, []},
  {applications, [stdlib, kernel]},
  {env, []},
  {runtime_dependencies, ["stdlib-2.0","kernel-3.0","erts-6.0"]}
 ]}.
