(*
 * Version macros.
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *)

{$ifndef AVFORMAT_VERSION_H}
  {$define AVFORMAT_VERSION_H}

const

	LIB_AVFORMAT = 'avformat-56';
	LIBAVFORMAT_VERSION_MAJOR   = 56;
	LIBAVFORMAT_VERSION_MINOR   = 40;
	LIBAVFORMAT_VERSION_MICRO   = 101;
  //LIBAVFORMAT_VERSION        = AV_VERSION(LIBAVFORMAT_VERSION_MAJOR, LIBAVFORMAT_VERSION_MINOR, LIBAVFORMAT_VERSION_MICRO);
	LIBAVFORMAT_VERSION_INT    = ((LIBAVFORMAT_VERSION_MAJOR shl 16) or (LIBAVFORMAT_VERSION_MINOR shl 8) or LIBAVFORMAT_VERSION_MICRO);
  LIBAVFORMAT_BUILD          = LIBAVFORMAT_VERSION_INT;
	LIBAVFORMAT_IDENT		       = 'Lavf';

(**
 * FF_API_* defines may be placed below to indicate public API that will be
 * dropped at a future version bump. The defines themselves are not part of
 * the public API and may change, break or disappear at any time.
 *
 * @note, when bumping the major version it is recommended to manually
 * disable each FF_API_* in its own commit instead of disabling them all
 * at once through the bump. This improves the git bisect-ability of the change.
 *
 *)
{$ifndef  FF_API_LAVF_BITEXACT}
  FF_API_LAVF_BITEXACT           = (LIBAVFORMAT_VERSION_MAJOR < 57);
{$endif}
{$ifndef  FF_API_LAVF_FRAC}
  FF_API_LAVF_FRAC               = (LIBAVFORMAT_VERSION_MAJOR < 57);
{$endif}
{$ifndef  FF_API_LAVF_CODEC_TB}
  FF_API_LAVF_CODEC_TB           = (LIBAVFORMAT_VERSION_MAJOR < 57);
{$endif}
{$ifndef  FF_API_URL_FEOF}
  FF_API_URL_FEOF                = (LIBAVFORMAT_VERSION_MAJOR < 57);
{$endif}
{$ifndef  FF_API_PROBESIZE_32}
  FF_API_PROBESIZE_32            = (LIBAVFORMAT_VERSION_MAJOR < 57);
{$endif}
{$ifndef  FF_API_R_FRAME_RATE}
  FF_API_R_FRAME_RATE           = 1;
{$endif}

{$endif} (* AVFORMAT_VERSION_H *)
	

