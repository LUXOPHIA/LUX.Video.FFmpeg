(*
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

{$ifndef AVFILTER_BUFFERSRC_H}
{$define AVFILTER_BUFFERSRC_H}

(**
 * @file
 * @ingroup lavfi_buffersrc
 * Memory buffer source API.
 *)


(**
 * @defgroup lavfi_buffersrc Buffer source API
 * @ingroup lavfi
 * @{
 *)

type
  TAV_BUFFERSRC_FLAG = (

    (**
     * Do not check for format changes.
     *)
    AV_BUFFERSRC_FLAG_NO_CHECK_FORMAT = 1,

{$IF FF_API_AVFILTERBUFFER}
    (**
     * Ignored
     *)
    AV_BUFFERSRC_FLAG_NO_COPY = 2,
{$ENDIF}

    (**
     * Immediately push the frame to the output.
     *)
    AV_BUFFERSRC_FLAG_PUSH = 4,

    (**
     * Keep a reference to the frame.
     * If the frame if reference-counted, create a new reference; otherwise
     * copy the frame data.
     *)
    AV_BUFFERSRC_FLAG_KEEP_REF = 8

  );

{$IF FF_API_AVFILTERBUFFER}
(**
 * Add buffer data in picref to buffer_src.
 *
 * @param buffer_src  pointer to a buffer source context
 * @param picref      a buffer reference, or NULL to mark EOF
 * @param flags       a combination of AV_BUFFERSRC_FLAG_*
 * @return            >= 0 in case of success, a negative AVERROR code
 *                    in case of failure
 *)
function av_buffersrc_add_ref(buffer_src: PAVFilterContext;
                         picref: PAVFilterBufferRef; flags: integer): integer;
    cdecl; external LIB_AVFILTER; deprecated;
{$ENDIF}

(**
 * Get the number of failed requests.
 *
 * A failed request is when the request_frame method is called while no
 * frame is present in the buffer.
 * The number is reset when a frame is added.
 *)
function av_buffersrc_get_nb_failed_requests(buffer_src: PAVFilterContext): cardinal;
    cdecl; external LIB_AVFILTER;

{$IF FF_API_AVFILTERBUFFER}
(**
 * Add a buffer to a filtergraph.
 *
 * @param ctx an instance of the buffersrc filter
 * @param buf buffer containing frame data to be passed down the filtergraph.
 * This function will take ownership of buf, the user must not free it.
 * A NULL buf signals EOF -- i.e. no more frames will be sent to this filter.
 *
 * @deprecated use av_buffersrc_write_frame() or av_buffersrc_add_frame()
 *)
function av_buffersrc_buffer(ctx: PAVFilterContext; buf: PAVFilterBufferRef): integer; deprecated 'use av_buffersrc_write_frame() or av_buffersrc_add_frame()';
    cdecl; external LIB_AVFILTER;
{$ENDIF}

(**
 * Add a frame to the buffer source.
 *
 * @param ctx   an instance of the buffersrc filter
 * @param frame frame to be added. If the frame is reference counted, this
 * function will make a new reference to it. Otherwise the frame data will be
 * copied.
 *
 * @return 0 on success, a negative AVERROR on error
 *
 * This function is equivalent to av_buffersrc_add_frame_flags() with the
 * AV_BUFFERSRC_FLAG_KEEP_REF flag.
 *)
function av_buffersrc_write_frame(ctx: PAVFilterContext; const frame: PAVFrame): integer;
    cdecl; external LIB_AVFILTER;

(**
 * Add a frame to the buffer source.
 *
 * @param ctx   an instance of the buffersrc filter
 * @param frame frame to be added. If the frame is reference counted, this
 * function will take ownership of the reference(s) and reset the frame.
 * Otherwise the frame data will be copied. If this function returns an error,
 * the input frame is not touched.
 *
 * @return 0 on success, a negative AVERROR on error.
 *
 * @note the difference between this function and av_buffersrc_write_frame() is
 * that av_buffersrc_write_frame() creates a new reference to the input frame,
 * while this function takes ownership of the reference passed to it.
 *
 * This function is equivalent to av_buffersrc_add_frame_flags() without the
 * AV_BUFFERSRC_FLAG_KEEP_REF flag.
 *)
function av_buffersrc_add_frame(ctx: PAVFilterContext; frame: PAVFrame): integer;
    cdecl; external LIB_AVFILTER;

(**
 * Add a frame to the buffer source.
 *
 * By default, if the frame is reference-counted, this function will take
 * ownership of the reference(s) and reset the frame. This can be controlled
 * using the flags.
 *
 * If this function returns an error, the input frame is not touched.
 *
 * @param buffer_src  pointer to a buffer source context
 * @param frame       a frame, or NULL to mark EOF
 * @param flags       a combination of AV_BUFFERSRC_FLAG_*
 * @return            >= 0 in case of success, a negative AVERROR code
 *                    in case of failure
 *)
function av_buffersrc_add_frame_flags(buffer_src: PAVFilterContext;
                                 frame: PAVFrame; flags: integer): integer;
    cdecl; external LIB_AVFILTER; (* verified: mail@freehand.com.ua, 2014-09-15: + *)

(**
 * @}
 *)

{$endif} (* AVFILTER_BUFFERSRC_H *)
